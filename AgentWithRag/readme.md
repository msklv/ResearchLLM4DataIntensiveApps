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

### Модели для генерации текста

* `Qwen/Qwen3.5-4B`
* `Qwen/Qwen3.5-2B`
* `Qwen/Qwen3.5-0.8B`
* `google/gemma-4-E2B-it`
* `google/gemma-4-E2B-it-assistant`
* `google/gemma-4-E4B-it`
* `google/gemma-4-E4B-it-assistant`

### Эмбединги

Для преобразования текстов в векторные представления:

* `Qwen/Qwen3-Embedding-0.6B` (default, requires 25GB RAM/vRAM to load)
* `BAAI/bge-m3` (requires 21GB RAM/vRAM to load)

## Локальный инференс

Запуск окруждения

```bash
#GPU:  
docker compose --profile gpu up -d 
#CPU:  
docker compose --profile cpu up -d 
```

### Apple Silicon

Для настоящего ускорения на Apple Silicon нужен не Docker, а локальный запуск TEI с Metal:  

```bash
brew install text-embeddings-inference
text-embeddings-router --model-id Qwen/Qwen3-Embedding-0.6B --port 9090 .
```

Документация Hugging Face прямо описывает Metal-вариант как локальную установку на Apple Silicon, а в Docker MPS/Metal сейчас не поддерживается, поэтому контейнерный вариант на Mac фактически CPU-only.

## Проверка работы

* [Qdrant dashboard](http://localhost:6333/dashboard)
* [Ollama endpoint](http://localhost:11434)
* [TEI endpoint](http://localhost:9090)
