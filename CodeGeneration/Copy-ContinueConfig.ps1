<#
.SYNOPSIS
    Копирует файл ~/.continue/config.yaml в папку, где находится этот скрипт.

.DESCRIPTION
    На macOS (и Linux) домашний каталог пользователя находится в $HOME,
    а в Windows — в $env:USERPROFILE.  $PSScriptRoot хранит путь к
    каталогу, из которого запущен скрипт.  Скрипт проверяет наличие
    исходного файла и, при необходимости, создаёт целевой каталог.

.NOTES
    Требуется PowerShell 7+ (можно запустить и в Windows PowerShell,
    но рекомендуется использовать кроссплатформенный PowerShell).
#>

# -------------------------------------------------
# 1. Определяем пути
# -------------------------------------------------
# Путь к домашнему каталогу текущего пользователя
$homePath = $HOME    # в PowerShell $HOME = $env:USERPROFILE (Win) или $env:HOME (Unix)

# Путь к исходному файлу
$sourceFile = Join-Path -Path $homePath -ChildPath ".continue/config.yaml"

# Путь к папке скрипта (рабочей папке)
$destFolder = $PSScriptRoot   # если скрипт запущен «из‑под» другого процесса,
                               # замените на (Get-Location).Path

# Путь к целевому файлу
$destFile   = Join-Path -Path $destFolder -ChildPath "config.yaml"

# -------------------------------------------------
# 2. Проверяем наличие исходного файла
# -------------------------------------------------
if (-not (Test-Path -LiteralPath $sourceFile)) {
    Write-Error "Исходный файл не найден: $sourceFile"
    exit 1
}

# -------------------------------------------------
# 3. Копируем файл
# -------------------------------------------------
try {
    # Если целевой файл уже существует, перезаписать его
    Copy-Item -LiteralPath $sourceFile -Destination $destFile -Force -ErrorAction Stop
    Write-Host "Файл успешно скопирован в: $destFile" -ForegroundColor Green
}
catch {
    Write-Error "Не удалось скопировать файл: $_"
    exit 1
}
