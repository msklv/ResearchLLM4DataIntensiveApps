# Demo Agent with RAG

## [Подготовка окружения](/docs/MacBookLLMSetupGuide.md)

* Python и UV
* Docker и Docker Compose
* Jupyter Lab и Jupyter Notebook
* VS Code
* Ollama или LM Studio

## Краткое описание элементов

* [Qdrant](https://qdrant.tech/) - векторная база данных, которая позволяет хранить и обрабатывать векторные представления данных.
* [LangChain](https://python.langchain.com/docs/introduction/) - библиотека для работы с LLM, которая предоставляет инструменты для создания приложений на основе языковых моделей, в том числе Агентного поиска, обработки текста и других задач. [Архитектура](https://github.com/langchain-ai/rag-from-scratch)
* [Jupyter Notebook](https://jupyter.org/) - интерактивная среда для работы с Python и другими языками программирования. Она позволяет создавать и делиться документами, содержащими код, текст и визуализации.

## Описание моделей

### Бенчмарки сравнения LLM для русского языка

* Рейтинг на HF https://huggingface.co/models?language=ru&other=text-embeddings-inference&sort=trending
* <https://mera.a-ai.ru/ru/text>
* <https://huggingface.co/spaces/mteb/leaderboard>

### Эмбединги

Для преобразования текстов в векторные представления:

* [mxbai-embed-large](https://huggingface.co/mixedbread-ai/mxbai-embed-large-v1)
* ai-forever/FRIDA
* Qwen/Qwen3-Embedding-8B
* BAAI/bge-m3 

### Модели для генерации текста

* [Gemma3](https://huggingface.co/google/gemma-3-12b-it) - довольно быстрая и эффективная LLM модель от Google.
* openai/gpt-oss-20b - открытая средняя модель от Open AI
* Qwen/Qwen3-8B - хорошая малая модель от Alibaba

## Локальный инференс 

- Запуск на Ollama:

```bash
export OLLAMA_TIMEOUT=600s      # Увеличиваем таймаут API до 10 минут
export OLLAMA_LOAD_TIMEOUT=10m  # Увеличиваем таймаут загрузки модели до 10 минут
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
