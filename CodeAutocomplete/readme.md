# Open Source Code autocomplete in IDE

## [Подготовка окружения](/docs/MacBookLLMSetupGuide.md)

## AI-ассистенты
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
- **Continue** – <https://marketplace.visualstudio.com/items?itemName=Continue.continue>
- **Kilo-Code** - <https://marketplace.visualstudio.com/items?itemName=kilocode.Kilo-Code>


### Рекомендации по выбору модели от continue.dev

- Рекомендованные модели - <https://docs.continue.dev/features/agent/model-setup#recommended-agent-models>
- Поддерживаемые модели - [model-capabilities](https://docs.continue.dev/customize/deep-dives/model-capabilities)

### Полезные горячие клавиши Continue

- `Cmd+L` — открыть чат с LLM.
- `Cmd+I` — inline-редактирование выделенного кода через LLM.
- `Cmd+Shift+L` — отправить выделенный код в чат как контекст.
- `Tab` — принять автокомплит.


### Настройка Continue для работы с Ollama

После установки расширения Continue создайте или отредактируйте конфигурацию `~/.continue/configs/config.yaml`:

```yaml
name: Local LLM Config
version: 0.0.1
schema: v1
models:
  # Основная модель для чата и редактирования
  - name: DeepSeek R1 32B
    provider: ollama
    model: deepseek-r1:32b
    roles:
      - chat
      - edit
      - apply
    completionOptions:
      temperature: 0.7
      contextLength: 8192
  
  # Быстрая модель для автокомплита
  - name: Qwen Coder 1.5B
    provider: ollama
    model: qwen2.5-coder:1.5b
    roles:
      - autocomplete
```

Альтернативно используйте **Autodetect** — Continue автоматически найдёт все модели из `ollama list`:

```yaml
models:
  - name: Autodetect
    provider: ollama
    model: AUTODETECT
    roles:
      - chat
      - edit
      - apply
      - autocomplete
```



### Конфигурация continue

Пример конфигурации для автопродления кода в файле `config.yaml`.

- [Документация по конфигурации](https://docs.continue.dev/customize/deep-dives/configuration)
- Настройка <https://docs.continue.dev/customize/model-roles/>
- Подробная настройка автопродления: <https://docs.continue.dev/customize/deep-dives/autocomplete>
