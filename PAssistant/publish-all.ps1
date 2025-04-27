# Параметры
$configuration = "Release"
$outputBase = "./publish"

# Платформы для сборки
$runtimes = @(
    "win-x64",
    "linux-x64",
    "osx-arm64"
)

# Очистка старых билдов
if (Test-Path $outputBase) {
    Remove-Item $outputBase -Recurse -Force
}
New-Item -ItemType Directory -Path $outputBase | Out-Null

# Сборка для каждой платформы
foreach ($rid in $runtimes) {
    Write-Host "Publishing for $rid..."

    dotnet publish `
        -c $configuration `
        -r $rid `
        --self-contained true `
        -o "$outputBase/$rid"

    Write-Host "Published to $outputBase/$rid"
    Write-Host
}

# Добавление прав на выполнение для Linux и macOS
foreach ($rid in $runtimes | Where-Object { $_ -ne "win-x64" }) {
    chmod +x "$outputBase/$rid/PAssistant"
}

Write-Host "✅ Сборка завершена для всех платформ!"
