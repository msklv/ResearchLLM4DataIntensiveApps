# Open Source Code Generation in IDE

## Окружение

- **VS Code** – <https://code.visualstudio.com/>
- **Ollama** – <https://ollama.com/>
- **continue.dev** – <https://continue.dev>
- **Sber Cloud** – <https://cloud.ru/> (для тестирования моделей)

## Модели

- Qwen2.5‑Coder‑7B‑Instruct – для локального использования <https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct>
- Qwen2.5‑Coder‑32B‑Instruct – для инференса на корпоративных серверах <https://huggingface.co/Qwen/Qwen2.5-Coder-32B-Instruct>
- Qwen3-Coder-480B-A35B-Instruct - для инференса на корпоративных серверах <https://huggingface.co/Qwen/Qwen3-Coder-480B-A35B-Instruct>

## Документация по Sber Cloud

- <https://cloud.ru/offers/aktsiya-evolution-foundation-models>
- <https://cloud.ru/solutions/ml-modeli>

## Ollama

Установите по официальной инструкции (<https://ollama.com/download>) или через Homebrew.

## Continue.dev

Установите из Marketplace VS Code: **Continue** – <https://marketplace.visualstudio.com/items?itemName=Continue.continue>

Официальный сайт: <https://continue.dev>

### Рекомендации по выбору модели от continue.dev

- Рекомендованные модели - <https://docs.continue.dev/features/agent/model-setup#recommended-agent-models>
- Поддерживаемые модели - [model-capabilities](https://docs.continue.dev/customize/deep-dives/model-capabilities)

### Конфигурация continue

Пример конфигурации для автопродления кода в файле `config.yaml`

[Документация по конфигурации](https://docs.continue.dev/customize/deep-dives/configuration)

```bash
.continue/      # Папка с конфигурацией continue.dev
config.yaml     # Конфигурационный файл
.env            # Файл с переменными окружения
```

- Настройка <https://docs.continue.dev/customize/model-roles/>
- Подробная настройка автопродления: <https://docs.continue.dev/customize/deep-dives/autocomplete>
