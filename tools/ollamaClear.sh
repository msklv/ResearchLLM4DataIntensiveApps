#!/bin/bash
# Остановить Ollama, если работает
pkill Ollama

# Удалить базу истории
rm -f ~/Library/Application\ Support/Ollama/db.sqlite

# Запустить Ollama заново (опционально, если используется автозапуск)
open -a Ollama

echo "История Ollama db.sqlite очищена."
