# Подготовка MacBook для работы с LLM: полное руководство

Это руководство охватывает настройку рабочего окружения на MacBook с Apple Silicon (M1–M5) с 16+ GB RAM для локальной работы с большими языковыми моделями — от управления Python-окружениями до запуска моделей и интеграции с IDE.

Ключевые элементы:

- Docker
- Python и UV
- jupyter notebook
- VS Code

---

## Предварительные требования

Перед установкой основных инструментов необходимо подготовить систему.

### Xcode Command Line Tools

Apple Command Line Tools содержат базовые Unix-утилиты (компиляторы, `git`, `make`), без которых не работают ни Homebrew, ни UV, ни большинство dev-инструментов.

```bash
xcode-select --install
```

В появившемся диалоге нажмите **Install** и дождитесь завершения.

### Homebrew

[Homebrew](https://brew.sh/) — стандартный пакетный менеджер для macOS, через который удобно ставить CLI-инструменты. Инструкция на сайте.

---

## Python и UV

### Почему UV

[UV](https://github.com/astral-sh/uv) — это менеджер Python-проектов и пакетов, написанный на Rust. Он в 10–100× быстрее pip, автоматически управляет виртуальными окружениями, устанавливает нужные версии Python и заменяет собой связку `pyenv + pip + venv + pip-tools`.

### Установка UV

Рекомендуемый способ — standalone-инсталлятор от Astral:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Альтернативно через Homebrew [^14]:

```bash
brew install uv
```

Проверка установки:

```bash
uv --version
```

Включите автодополнение для zsh:

```bash
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### Установка Python через UV

UV сам скачивает и управляет версиями Python — отдельно ставить ничего не нужно:

```bash
# Установить последнюю стабильную версию
uv python install

# Установить несколько версий
uv python install 3.11 3.12 3.13

# Посмотреть установленные версии
uv python list
```

### Создание проекта

```bash
# Инициализация нового проекта
uv init my-llm-project
cd my-llm-project

# Структура после init:
# my-llm-project/
# ├── .python-version     # Закреплённая версия Python
# ├── pyproject.toml      # Конфигурация проекта
# ├── main.py
# └── README.md
```

### Управление зависимостями

```bash
# Добавить зависимость
uv add requests langchain openai

# Добавить dev-зависимость
uv add --dev pytest ruff mypy

# Синхронизировать окружение
uv sync

# Запуск скрипта через uv (автоматически подбирает окружение)
uv run python main.py
```

### Лучшие практики UV

- **Всегда используйте `uv add`** вместо `pip install` — это обновляет `pyproject.toml` и `uv.lock` автоматически.
- **Коммитьте `uv.lock`** в систему контроля версий — он обеспечивает воспроизводимость сборки.
- **Используйте `uv run`** для запуска скриптов вместо ручной активации виртуального окружения.
- **Указывайте `requires-python >= 3.12`** в `pyproject.toml` без верхней границы.
- **Отдельные `.python-version` файлы** в каждом проекте для закрепления конкретной версии Python.

---

## Локальный инференс: Ollama

### Установка Ollama

Ollama — легковесный runtime для запуска open-source LLM с автоматическим использованием Metal GPU на Apple Silicon. На macOS не требуется никакая дополнительная конфигурация GPU — Metal задействуется автоматически.

**Вариант 1 — DMG (рекомендуется):** скачайте с [ollama.com](https://ollama.com), перетащите в Applications.

**Вариант 2 — Homebrew**:

```bash
brew install ollama
```

Проверка:

```bash
ollama --version
```

### Запуск и базовое использование

```bash
# Запустить сервис (если установлен через Homebrew/скрипт)
ollama serve

# Скачать и запустить модель
ollama run llama3.1:8b

# Скачать модель без запуска
ollama pull qwen2.5-coder:7b

# Посмотреть скачанные модели
ollama list

# Посмотреть запущенные модели и использование памяти
ollama ps
```

После запуска Ollama поднимает API-сервер на `http://localhost:11434`, совместимый с OpenAI API.


### Ключевые переменные окружения

Для кастомизации поведения Ollama используйте переменные окружения:

```bash
# Изменить каталог хранения моделей (по умолчанию ~/.ollama)
export OLLAMA_MODELS="/Volumes/ExternalSSD/ollama-models"

# Открыть API для сети (для доступа с других машин)
export OLLAMA_HOST="0.0.0.0:11434"

# Включить подробные логи
export OLLAMA_DEBUG=1
```

Для постоянного применения добавьте эти строки в `~/.zshrc`.

Также можно создать Modelfile - конфигурационный файл в Ollama (аналог Dockerfile), с помощью которого ты описываешь, какую базовую модель взять и как именно её запускать и вести себя. Через Modelfile можно управлять числом GPU-слоёв, количеством потоков CPU и размером контекстного окна.

---

## Локальный инференс: LM Studio

### Установка

LM Studio — десктопное приложение с графическим интерфейсом для скачивания и запуска LLM. Скачайте установщик с [lmstudio.ai](https://lmstudio.ai) и перетащите в Applications.

### Ключевые преимущества LM Studio:

- **MLX Backend** - LM Studio поддерживает Apple MLX — фреймворк, специально оптимизированный для Apple Silicon. MLX использует unified memory архитектуру с zero-copy операциями между CPU и GPU, что даёт значительный прирост скорости по сравнению с обычным GGUF-инференсом через llama.cpp.
- **Подсказки при выборе моделей для данного железа** - что запуститься а что нет, а что будет работать максимально быстро.

### Запуск локального API-сервера

LM Studio предоставляет OpenAI-совместимый API — это позволяет использовать локальную модель в своих скриптах и приложениях [^2][^34]:

1. Откройте раздел **Developer** в боковой панели.
2. Переключите **Status** на **Running**.
3. Включите **Enable CORS** в настройках.
4. API доступен по адресу `http://127.0.0.1:1234`.

Проверка:

```bash
curl http://127.0.0.1:1234/v1/models
```

---

## VS Code

### Установка

```bash
brew install --cask visual-studio-code
```

### Обязательные расширения для LLM-разработки

Откройте Extensions (`Cmd+Shift+X`) и установите:

**Python и Jupyter:**
- **Python** (ms-python.python) — базовая поддержка Python, линтинг, дебаг.
- **Jupyter** (ms-toolsai.jupyter) — запуск `.ipynb` файлов прямо в редакторе .
- **Pylance** (ms-python.vscode-pylance) — быстрый LSP для Python с типизацией.
- **Ruff** (charliermarsh.ruff) — быстрый линтер и форматтер (от Astral, создателей UV).


### Настройка VS Code settings.json

Полезные настройки для LLM-разработки:

```json
{
    "python.defaultInterpreterPath": ".venv/bin/python",
    "python.terminal.activateEnvironment": true,
    "[python]": {
        "editor.defaultFormatter": "charliermarsh.ruff",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.fixAll.ruff": "explicit",
            "source.organizeImports.ruff": "explicit"
        }
    },
    "jupyter.askForKernelRestart": false,
    "notebook.formatOnSave.enabled": true
}
```


---

## Jupyter Notebook

### Интеграция UV + Jupyter + VS Code

Для запуска Jupyter-ноутбуков в VS Code с UV-окружением нужно установить зависимости и зарегистрировать ядро.

**Шаг 1 — Добавьте Jupyter-зависимости в проект:**

```bash
cd my-llm-project
uv add jupyter ipykernel notebook
uv sync
```

**Шаг 2 — Зарегистрируйте ядро (kernel):**

```bash
uv run python -m ipykernel install --user \
  --name=my-llm-project \
  --display-name "My LLM Project (Python 3.12)"
```

Либо без `uv run`, напрямую через путь к интерпретатору:

```bash
./.venv/bin/python -m ipykernel install --user \
  --name=my-llm-project \
  --display-name "My LLM Project"
```

**Шаг 3 — Откройте `.ipynb` в VS Code:**

1. Создайте или откройте ноутбук: `Cmd+Shift+P` → "Create: New Jupyter Notebook".
2. В правом верхнем углу нажмите **Select Kernel**.
3. Выберите ваше UV-окружение (`My LLM Project`) из списка.

Если ядро не появляется — перезагрузите VS Code или нажмите кнопку обновления в kernel picker [^26].

### Пример: подключение к Ollama из ноутбука

```python
# Первая ячейка: установка зависимостей (если не добавлены через uv add)
# !uv add openai

from openai import OpenAI

# Ollama предоставляет OpenAI-совместимый API
client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"  # Значение не проверяется, но параметр обязательный
)

response = client.chat.completions.create(
    model="llama3.1:8b",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Explain transformer attention in 3 sentences."}
    ]
)

print(response.choices.message.content)
```

### Пример: подключение к LM Studio

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://127.0.0.1:1234/v1",
    api_key="lm-studio"
)

response = client.chat.completions.create(
    model="<имя модели из LM Studio>",
    messages=[
        {"role": "user", "content": "Write a quicksort implementation in Python."}
    ]
)

print(response.choices.message.content)
```

### Запуск JupyterLab (вне VS Code)

Если нужен классический веб-интерфейс [^26]:

```bash
uv run jupyter lab
# или
uv run jupyter notebook
```



## Установка Docker Desktop

### Вариант 1 — Homebrew (рекомендуется)

```bash
brew install --cask docker
```

### Вариант 2 — DMG-установщик

Скачайте с [docker.com](https://www.docker.com/products/docker-desktop/), откройте DMG и перетащите Docker в Applications.



### Предпочитайте ARM64-образы

На Apple Silicon используйте нативные ARM64-образы — они работают значительно быстрее, чем AMD64 через эмуляцию [^44]:

```bash
# Проверить архитектуру образа
docker inspect --format='{{.Architecture}}' python:3.12-slim
# arm64

# Явно указать платформу при необходимости
docker pull --platform linux/arm64 python:3.12-slim
```

### Интеграция с VS Code - Расширение Docker

- Расширение **Docker** (ms-azuretools.vscode-docker) для управления контейнерами, образами и Compose-файлами прямо из IDE.
- Расширение **Dev Containers** (ms-vscode-remote.remote-containers) позволяет вести разработку внутри контейнера с полной поддержкой IntelliSense и дебага.


## Полезные команды на каждый день

```bash
# Очистка неиспользуемых ресурсов
docker system prune -a --volumes

# Посмотреть использование диска
docker system df

# Логи контейнера (последние 100 строк, follow)
docker logs --tail 100 -f <container>

# Зайти в работающий контейнер
docker exec -it <container> bash

# Собрать образ с использованием BuildKit (по умолчанию)
docker build -t myapp .

# Запуск с ограничением ресурсов
docker run --memory=4g --cpus=2 myapp
```
