# Скрипт тестирования и прогрева LLM моделей


# _______________ Константы  ________
$serverUrl = "http://localhost:11434"   # Ollama-сервера



# _______________ Функции _____________

# Функция Проверки подключения к серверу
function CheckServerConnection {
    param (
        [string]$serverUrl
    )
    Write-Host "`Проверка доступности Ollama-сервера..."
    try {
        Invoke-RestMethod -Uri "$serverUrl/api/tags" -Method Get -TimeoutSec 5 > $null
        Write-Host "✅ Ollama сервер доступен!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Не удалось подключиться к Ollama серверу по адресу $serverUrl" -ForegroundColor Red
        exit 1
    }
}


# Прогрев LLM модели
function WarmupLLMModel {
    param (
        [string]$llmModel
    )
    
    $llmPrompt = "Объясни кратко, как работает Retrieval-Augmented Generation (RAG)."
    $llmPayload = @{
        model = $llmModel
        prompt = $llmPrompt
        stream = $false
    } | ConvertTo-Json -Depth 3
    
    Write-Host "`Запрос к LLM модели '$llmModel'..." -ForegroundColor Cyan
    try {
        $llmResponse = Invoke-RestMethod -Uri "$serverUrl/api/generate" -Method Post -Body $llmPayload -ContentType "application/json"
        Write-Host "📢 Ответ от LLM:" -ForegroundColor Green
        Write-Host $llmResponse.response
    } catch {
        Write-Host "❌ Ошибка при запросе к LLM модели" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}


# Проверка доступности модели
function CheckModelAvailability {
    param (
        [string]$model
    )

    Write-Host "`Проверка доступности модели '$model'..."
    # Выполняем запрос к API сервера Ollama для проверки наличия модели
    # Используем метод POST и передаем JSON с именем модели в теле запроса
    # curl http://localhost:11434/api/show -d '{ "model": "gemma3:12b-it-q4_K_M" }'
    $showPayload = @{
        model = $model
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri "$serverUrl/api/show" -Method Post -Body $showPayload -ContentType "application/json" -TimeoutSec 5 -ErrorAction Stop
        Write-Host $response.modified_at -ForegroundColor DarkGray
        write-host $response.details -ForegroundColor DarkGray
        if ($response.details) {
            Write-Host "✅ Модель '$model' доступна!" -ForegroundColor Green
        } else {
            Write-Host "❌ Модель '$model' недоступна." -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ Ошибка при проверке доступности модели '$model'" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }

}


# Функция для прогрева Embedding модели
function WarmupEmbeddingModel {
    param (
        [string]$embedModel
    )
    $embedPrompt = "Это пример текста, который нужно преобразовать в вектор."
    $embedPayload = @{
        model = $embedModel
        prompt = $embedPrompt
    } | ConvertTo-Json -Depth 3
    
    Write-Host "`Запрос к модели эмбеддингов '$embedModel'..." -ForegroundColor Cyan
    try {
        $embedResponse = Invoke-RestMethod -Uri "$serverUrl/api/embeddings" -Method Post -Body $embedPayload -ContentType "application/json"
        Write-Host "📊 Получен эмбеддинг длиной $($embedResponse.embedding.Count)" -ForegroundColor Green
    } catch {
        Write-Host "❌ Ошибка при запросе к embedding модели" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }

}


# Проверка + прогрев RAG сценария 
function ScenarioRAG {
    $llmModel   = "gemma3:12b-it-q4_K_M"
    $embedModel = "mxbai-embed-large"

    CheckServerConnection -serverUrl $serverUrl > $null

    CheckModelAvailability -model $llmModel > $null
    CheckModelAvailability -model $embedModel > $null

    WarmupLLMModel -llmModel $llmModel > $null
    WarmupEmbeddingModel -embedModel $embedModel > $null

}


# Проверка + прогрев сценария генерации кода  
function ScenarioCodeGeneration  {
    $llmModel = "qwen2.5-coder:7b-instruct-q6_K"

    CheckServerConnection -serverUrl $serverUrl > $null

    CheckModelAvailability -model $llmModel > $null
    WarmupLLMModel -llmModel $llmModel > $null
}



# ________________ Маршрутизатор сценариев  _________________________

Write-Host
Write-Host "Запуск тестирования моделей Ollama..." -ForegroundColor Cyan
Write-Host "Пожалуйста, выберите один из следующих сценариев:"

$menu = @"
----------------------------------------
[1] Сценарий RAG
[2] Сценарий Code Generation
----------------------------------------
"@

Write-Host $menu

$validChoices = @("1", "2")
$scenarioChoice = ""
$attempts = 0
$maxAttempts = 5

while (-not ($validChoices -contains $scenarioChoice) -and $attempts -lt $maxAttempts) {
    $scenarioChoice = Read-Host "Введите номер сценария"
    if (-not ($validChoices -contains $scenarioChoice)) {
        $attempts++
        Write-Host "Неверный выбор сценария. Попытка $attempts из $maxAttempts."
    }
}

if ($attempts -eq $maxAttempts) {
    Write-Host "Превышено максимальное количество попыток. Завершение программы." -ForegroundColor Red
    exit
}

switch ($scenarioChoice) {
    "1" { ScenarioRAG }
    "2" { ScenarioCodeGeneration }
}