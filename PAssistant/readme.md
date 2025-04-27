# P Assistant

* Личный ассистент с подключении к Jira, Почте и Календарю и локальной документации
* Основан на Microsoft Semantic Kernel и C# (.NET SDK 8.0 )
* Используются с локальные open source LLM модели через Ollama

## Зависимости

* .NET SDK 9.0 или выше
* Microsoft Semantic Kernel [Документация](https://learn.microsoft.com/en-us/semantic-kernel/overview/)
* NuGet пакеты, указанные в файле `PAssistant.csproj`

## Структура проекта

* Settings — для конфигураций
* Skills — для плагинов Semantic Kernel
* Services — для бизнес-логики
* Models — для структур данных
