# PAssistant

* Личный ассистент с подключении к Jira, Почте и Календарю и локальной документации
* Основан на Microsoft Semantic Kernel и C# (.NET SDK 8.0 )
* Используются с локальные open source LLM модели через Ollama
* Перехват аудио потока созвонов и вывод подсказок

## Зависимости

* .NET SDK 9.0 или выше
* Microsoft Semantic Kernel [Документация](https://learn.microsoft.com/en-us/semantic-kernel/overview/)

## Краткое описание элементов

* [Ollama](https://ollama.com/) - инструмент для работы с моделями LLM локально, на Хосте пользователя.
* [Qdrant](https://qdrant.tech/) - векторная база данных, которая позволяет хранить и обрабатывать векторные представления данных.
* [Semantic Kernel](https://github.com/microsoft/semantic-kernel) - библиотека для создания приложений с использованием языковых моделей и интеграции с внешними источниками данных от Microsoft на C#.

## Хранение чувствительной информации

* Для хранения токенов и паролей используется [User Secrets](https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-7.0)

```bash
dotnet user-secrets init
dotnet user-secrets set "Jira:AuthToken" "your_token_here"
dotnet user-secrets set "Jira:Url" "https://jira.your_company.com"
```

В дальнейшем планируется перейти на `NetEscapades.Configuration.SecretManager` или внешнего `Key Vault`.

## Структура проекта

```tree
PAssistant/
├── appsettings.json                - Конфигурация приложения
├── Program.cs                      - Точка входа
├── publish-all.ps1                 - Сборка и публикация проекта под все платформы
├── Settings/                       - Работа с конфигурацией и инициализация
│   ├── AppSettings.cs
│   ├── GeneralSettings.cs
│   ├── JiraSettings.cs
│   ├── OllamaSettings.cs
├── Skills/                         - Навыки Semantic Kernel
│   ├── JiraSkill.cs
├── Validators/                     - Проверки
│   ├── StartupValidator.cs         - Проверки настроек и окружения при запуске
```
