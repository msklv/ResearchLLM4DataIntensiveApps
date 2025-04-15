# Assistant with RAG

## Окружение
- Python 3.13
- Docker и Docker Compose
- Jupyter Lab и Jupyter Notebook
- Ollama


## Ollama
- [Ollama](https://ollama.com/) - это инструмент для работы с моделями LLM, который позволяет запускать и использовать модели на локальной машине. Он поддерживает различные модели, такие как Llama 2, Mistral и другие.
- Установка Ollama:
```bash
brew install ollama/tap/ollama
```
- Запуск Ollama:
```bash
export OLLAMA_TIMEOUT=600s  # Увеличиваем таймаут API до 10 минут
export OLLAMA_DEBUG=true    # Включаем режим отладки
ollama pull mxbai-embed-large
ollama serve
```


## Запуск окружения в Docker
```bash
docker compose up -d 
```


## Проверка работы

- [Qdrant](http://localhost:6333/dashboard)



