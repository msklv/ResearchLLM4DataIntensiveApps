# P Assistant

* Личный ассистент с подключении к Jira, Почте и Календарю и локальной документации
* Основан на Microsoft Semantic Kernel и C# (.NET SDK 8.0 )
* Используются с локальные open source LLM модели через Ollama

## Зависимости

* .NET SDK 9.0 или выше
* Microsoft Semantic Kernel [Документация](https://learn.microsoft.com/en-us/semantic-kernel/overview/)
* NuGet пакеты, указанные в файле `PAssistant.csproj`

## Хранение чувствительной информации

* Для хранения токенов и паролей используется [User Secrets](https://learn.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-7.0)

```bash
dotnet user-secrets init
dotnet user-secrets set "Jira:AuthToken" "your_token_here"
```

В дальнейшем планируется перейти на `NetEscapades.Configuration.SecretManager` или внешнего `Key Vault`.

## Структура проекта

* Settings — для конфигураций
* Skills — для плагинов Semantic Kernel
* Services — для бизнес-логики
* Models — для структур данных
