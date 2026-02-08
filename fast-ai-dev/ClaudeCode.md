# Claude Code

[Claude Code](https://github.com/anthropics/claude-code) — source‑available агент под проприетарной лицензией от Anthropic и заточенный под ее экосистему, но может работать через совместимый локальный инференс от Ollama или LM Studio.

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
