# Корпоративный портал для поиска информации

## Технологии

- Ollama ([Сбер для теста](https://foundation-models.api.cloud.ru/v1))
- open-webui
- [Qdrant](https://qdrant.tech/)
- Docker

## Быстрый старт (docker-compose)

Для локального тестирования стека (Ollama + Qdrant + Open WebUI) используйте `docker-compose` ниже.

### Запуск

```bash
# Поднять стек в фоне
docker compose up -d

### Остановка и очистка

```bash
# Остановить контейнеры
docker compose down

# Полностью удалить данные (векторы/модели/настройки)
rm -rf ./.data
```

### Открыть

- Qdrant: <http://localhost:6333/dashboard>
- WebUI: <http://localhost:3000/>

## Использование Open WebUI

- Админские данные задаются при первом запуске
