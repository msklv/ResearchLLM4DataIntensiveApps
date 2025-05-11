# Demo Agent with RAG

## Окружение запуска

* Python 3.13 ([установка](python.md))
* Docker и Docker Compose
* Jupyter Lab и Jupyter Notebook
* Ollama

## Краткое описание элементов

* [Ollama](https://ollama.com/) - инструмент для работы с моделями LLM локально, на Хосте пользователя.
* [Qdrant](https://qdrant.tech/) - векторная база данных, которая позволяет хранить и обрабатывать векторные представления данных.
* [LangChain](https://python.langchain.com/docs/introduction/) - библиотека для работы с LLM, которая предоставляет инструменты для создания приложений на основе языковых моделей, в том числе Агентного поиска, обработки текста и других задач. [Архитектура](https://github.com/langchain-ai/rag-from-scratch)
* [Jupyter Notebook](https://jupyter.org/) - интерактивная среда для работы с Python и другими языками программирования. Она позволяет создавать и делиться документами, содержащими код, текст и визуализации.

## Описание моделей

* [mxbai-embed-large](https://huggingface.co/mixedbread-ai/mxbai-embed-large-v1) - модель эмбеддинга, которая используется для преобразования текстов в векторные представления. Она позволяет эффективно представлять текстовые данные в виде векторов, что упрощает их обработку и анализ.
* [Gemma3](https://huggingface.co/google/gemma-3-12b-it) - модель от Google, для генерации текста на основе входных данных. Она может быть использована для создания различных приложений, таких как чат-боты, системы рекомендаций и другие.

## Ollama

- Установка Ollama:

```bash
brew install ollama/tap/ollama
```

- Запуск Ollama:

```bash
export OLLAMA_TIMEOUT=600s      # Увеличиваем таймаут API до 10 минут
export OLLAMA_LOAD_TIMEOUT=10m  # Увеличиваем таймаут загрузки модели до 10 минут
export OLLAMA_LOG_LEVEL=debug   # Устанавливаем уровень логирования на debug, если необходимо.
export OLLAMA_DEBUG=true        # Включаем режим отладки
ollama pull mxbai-embed-large
ollama run gemma3:12b-it-q4_K_M
ollama serve
```

## Запуск окружения в Docker

```bash
docker compose up -d 
```

## Проверка работы

- [Qdrant dashboard](http://localhost:6333/dashboard)
- [Ollama endpoint](http://localhost:11434)
