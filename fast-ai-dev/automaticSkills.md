# Automatic Skills Discovery

Mintlify‑документация теперь автоматически публикует индекс навыков по стандарту Well‑Known Skills Discovery (расширение RFC 8615). [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)

- Достаточно указать URL документации, CLI найдёт `/.well-known/skills/index.json`, покажет доступные навыки и установит их в поддерживаемые агенты (OpenCode, Claude Code и др.). [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)
- Если в репозитории лежит собственный `skill.md`, он переопределяет авто‑сгенерированную версию и позволяет тонко управлять тем, чему агент научится о вашем продукте. [mintlify](https://www.mintlify.com/blog/skills-discovery-from-any-url)

Пример:

```bash
npx skills add https://mintlify.com/docs
```

После установки навыки автоматически становятся доступны в поддерживаемых агентах и могут использоваться в сценариях быстрой разработки, ревью и диагностики в пределах локального/корпоративного LLM‑стека.


Для установки и распространения навыков используется единый CLI:

```bash
npx skills add <docs-url>
```