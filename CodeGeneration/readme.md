# Open Source code generation in IDE

## Окружение запуска

- VS Code
- Ollama
- continue.dev

## Краткое описание элементов

- [Ollama](https://ollama.com/) - инструмент для работы с моделями LLM, который позволяет запускать и использовать модели на локальной машине. Он поддерживает различные модели, такие как Llama 2, Mistral и другие.

## Описание моделей

- [Qwen2.5-Coder](https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct) - мощная модель кодирования, разработанная компанией Qwen. Она предназначена для выполнения задач, связанных с программированием, такими как автодополнение кода, рецензирование кода и другие.

## Принципы выбора локальных моделей

- Для MacBook M1 pro 16gb
- Для Windows Book c GTS 4070

## Сравнение Аренды и Покупки GPU

Когда покупка становится экономически целесообразна аренды?

## Ollama

### Установка Ollama и запуск

```bash
brew install ollama/tap/ollama
```

- Запуск Ollama:

```bash
export OLLAMA_TIMEOUT=600s      # Увеличиваем таймаут API до 10 минут
export OLLAMA_LOAD_TIMEOUT=10m  # Увеличиваем таймаут загрузки модели до 10 минут
export OLLAMA_LOG_LEVEL=debug   # Устанавливаем уровень логирования на debug, если необходимо.
export OLLAMA_DEBUG=true        # Включаем режим отладки
ollama pull qwen2.5-coder:7b-instruct-q6_K
ollama run qwen2.5-coder:7b-instruct-q6_K
ollama serve
```

### Проверка работы

- [Ollama endpoint](http://localhost:11434)

## continue.dev

### Установка

### Настройка

Есть вариант ini новый yaml, лучше выбирать 2-рой вариант.

`.continue/assistants/MyAssistant.yaml` - Пример конфигурации Yaml.
