# Open Source Code autocomplete in IDE

## Окружение

- **IDE VS Code** – <https://code.visualstudio.com/>
- [**Ollama**](https://ollama.com/) или [**LM Studio**](https://lmstudio.ai)

- **continue.dev** – <https://continue.dev>
- **KiloCode** - <https://github.com/Kilo-Org/kilocode>


## Модели

- [**Qwen2.5‑Coder‑7B**](https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct) или [**Qwen2.5‑Coder‑14B**](https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct) для быстрого локального использования, можно исполтзовать и боле большие модели этого дже семейства.
- **Qwen3-Coder** несколько хуже подходит именно для автопродления кода
- **glm-4.7-flash** тоже можно

## Локальный инференс

Установите по официальной инструкциzv [**Ollama**](https://ollama.com/) или [**LM Studio**](https://lmstudio.ai).


## Плагины

Установите из Marketplace VS Code:
-  **Continue** – <https://marketplace.visualstudio.com/items?itemName=Continue.continue>
- **Kilo-Code** - <https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code>


### Рекомендации по выбору модели от continue.dev

- Рекомендованные модели - <https://docs.continue.dev/features/agent/model-setup#recommended-agent-models>
- Поддерживаемые модели - [model-capabilities](https://docs.continue.dev/customize/deep-dives/model-capabilities)

### Конфигурация continue

Пример конфигурации для автопродления кода в файле `config.yaml`.

[Документация по конфигурации](https://docs.continue.dev/customize/deep-dives/configuration)
- Настройка <https://docs.continue.dev/customize/model-roles/>
- Подробная настройка автопродления: <https://docs.continue.dev/customize/deep-dives/autocomplete>
