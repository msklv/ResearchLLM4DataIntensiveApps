# P Assistant

## Зависимости

* .NET SDK 9.0 или выше
* Microsoft Semantic Kernel
* + NuGet пакеты, указанные в файле `PAssistant.csproj`






## Сборка

```bash
dotnet publish -c Release -r win-x64 --self-contained true -o ./publish/win-x64
dotnet publish -c Release -r linux-x64 --self-contained true -o ./publish/linux-x64
dotnet publish -c Release -r osx-arm64 --self-contained true -o ./publish/osx-arm64
chmod +x ./publish/osx-arm64/PAssistant
./publish/osx-arm64/PAssistant
```

