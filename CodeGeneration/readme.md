# Open Source code generation in IDE

## Окружение запуска

- [VS Code](https://code.visualstudio.com/)
- [Ollama](https://ollama.com/)
- [continue.dev](https://continue.dev)

## Краткое описание элементов

- [Ollama](https://ollama.com/) - инструмент для работы с моделями LLM, который позволяет запускать и использовать модели на локальной машине. Он поддерживает различные модели, такие как Llama 2, Mistral и другие.

## Описание моделей

- [Qwen2.5-Coder-7B-Instruct](https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct)
- [DeepSeek-Coder-V2-Lite-Instruct](https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct)
- [phi4-mini-reasoning](https://huggingface.co/microsoft/Phi-4-mini-reasoning)

| Модель                           | Параметры/Архитектура | Качество генерации кода | Скорость работы | Требования к RAM | Максимальный контекст | Русский язык | Лицензия      | Особенности                                 |
|-----------------------------------|-----------------------|------------------------|-----------------|------------------|----------------------|--------------|---------------|----------------------------------------------|
| Qwen2.5-Coder-7B-Instruct         | 7B, Transformer       | ★★★★☆                 | Средняя         | 10–16 ГБ (Q4)    | 128K                 | Хороший      | Apache 2.0    | Сильная генерация кода, широкий контекст     |
| DeepSeek-Coder-V2-Lite-Instruct   | 2.4B активных (MoE)   | ★★★★☆                 | Высокая         | 8–16 ГБ (Q4)     | 128K                 | Средний      | MIT           | Mixture-of-Experts, очень быстрый, 338 языков|
| phi4-mini-reasoning               | 3.8B, Transformer     | ★★★☆☆                 | Очень высокая   | 4–8 ГБ           | 32K                  | Средний      | MIT           | Компактная, быстрая, хорошо для reasoning    |

## Принципы выбора локальных моделей

- Для MacBook M1 pro 16gb
- Для Windows laptop c rtx-4070-family позволит увеличить производительность в 3-5 раз

## Сравнение Аренды и Покупки GPU

Когда покупка становится экономически целесообразна аренды?

## Ollama

### Установка Ollama и запуск

По инструкции с [официального сайта](https://ollama.com/download), или с помощью Homebrew:

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

Из маркетплейса VSCode [Continue](https://marketplace.visualstudio.com/items?itemName=Continue.continue).

### Пример конфигурации для Ollama

Есть вариант ini формата настроек и новый yaml, лучше выбирать 2-рой вариант.

[MyAssistant.yaml](../.continue/assistants/MyAssistant.yaml) - Пример конфигурации Yaml.

Настройка провайдера [Ollama](https://docs.continue.dev/customize/model-providers/ollama).
Глубокая настройка [continue](https://docs.continue.dev/customize/deep-dives/autocomplete).

### Добавляем контекст

- https://docs.continue.dev/customize/tutorials/build-your-own-context-provider
- https://docs.continue.dev/customize/tutorials/custom-code-rag
