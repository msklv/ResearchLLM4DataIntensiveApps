# Быстрая разработка ПО с использованием AI

Рассматриваем только решения могущие работать локально и с внутрикорпоративным инференсом LLM.  

## Агенты для разработки кода

Рекомендуемые кодовые агенты, умеющие работать с локальным/корпоративным инференсом:

- [OpenCode](https://opencode.ai)— открытый CLI/TUI‑агент, поддерживает локальные модели, MCP‑серверы и AGENTS.md/skills для настройки поведения.
- [Qwen‑Code](https://github.com/QwenLM/qwen-code) - кодовый агент от Alibaba, который может работать с локальными моделями и интегрируется в корпоративные процессы.

### Только локальный инференс
- [Claude Code](https://github.com/anthropics/claude-code) — кодовый агент от Антропик; может работать через совместимый локальный инференс - Ollama или LM Studio

```bash
# LM Studio
export ANTHROPIC_BASE_URL=http://localhost:1234
export ANTHROPIC_AUTH_TOKEN=lmstudio
claude --model zai-org/glm-4.7-flash

# Ollama
ollama launch claude --model glm-4.7-flash
# или
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434
```

## LLM модели для работы агентов

### Компактные модели
- qwen3-coder-30b
- glm-4.7-flash

### Большие модели
- Qwen/Qwen3-Coder-Next
- Qwen/Qwen3-Coder-480B-A35B-Instruct
- glm-4.7
- kimi-k2.5
- MiniMax M2.1
- DeepSeek-V3.2 ??

## MCP и интеграции

MCP — это стандартный способ подключать LLM‑клиента (OpenCode Agent, IDE и т.п.) к куче инструментов и данных через единый протокол клиент‑сервер, чтобы не плодить миллион ad‑hoc интеграций.

- [mcp-atlassian](https://github.com/sooperset/mcp-atlassian) — сервер, который по спецификации Anthropic MCP прокидывает on-premise Jira и Confluence в контекст AI‑агентов.


## Skills и тулзы агентов

Навыки (skills) позволяют упаковывать доменные знания и сценарии работы в единый формат, который понимают разные агенты:

- Spec-driven development
- Концепция Memory Bank
- [agents.md](https://agents.md) — конфигурация агентов и их ролей в проектах (контекст системы, ограничения, язык общения и пр.)
- [skill.md](https://agentskills.io) — описание отдельного навыка в формате Agent Skills; может храниться в репозитории продукта или в отдельном каталоге навыков.
- Роли разработки — набор предопределённых ролей (архитектор, backend‑разработчик, ревьюер, DevOps), которые задаются через AGENTS.md/skills и привязываются к конкретным моделям и тулзам. [opencode](https://opencode.ai/docs/agents/)

Для установки и распространения навыков используется единый CLI:

```bash
npx skills add <docs-url>
```

***

### Automatic Skills Discovery

Mintlify‑документация теперь автоматически публикует индекс навыков по стандарту Well‑Known Skills Discovery (расширение RFC 8615). [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)

- Достаточно указать URL документации, CLI найдёт `/.well-known/skills/index.json`, покажет доступные навыки и установит их в поддерживаемые агенты (OpenCode, Claude Code и др.). [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)
- Если в репозитории лежит собственный `skill.md`, он переопределяет авто‑сгенерированную версию и позволяет тонко управлять тем, чему агент научится о вашем продукте. [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)

Пример:

```bash
npx skills add https://mintlify.com/docs
```

После установки навыки автоматически становятся доступны в поддерживаемых агентах и могут использоваться в сценариях быстрой разработки, ревью и диагностики в пределах локального/корпоративного LLM‑стека.
