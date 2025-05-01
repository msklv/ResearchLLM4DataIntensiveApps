# Параметры
$configuration = "Release"
$outputBase = "./publish"


# Проверка рабочей директории
$currentDir = Get-Location
if ($currentDir -ne $PSScriptRoot) {
   # Меняем рабочий каталог на каталог скрипта
   Set-Location $PSScriptRoot
   Write-Host "Рабочий каталог изменен на $PSScriptRoot"
}

# Очистка старой папки
if (Test-Path $outputBase -PathType Container) {
    Remove-Item $outputBase -Recurse -Force
    Write-Host "Удалена старая папка $outputBase"
}
New-Item -ItemType Directory -Path $outputBase | Out-Null



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
