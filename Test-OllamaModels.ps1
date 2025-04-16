# Убедись, что сервер Ollama доступен
$serverUrl = "http://localhost:11434"

Write-Host "`n🟡 Проверка доступности Ollama-сервера..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$serverUrl/api/tags" -Method Get -TimeoutSec 5 > $null
    Write-Host "✅ Ollama сервер доступен!" -ForegroundColor Green
} catch {
    Write-Host "❌ Не удалось подключиться к Ollama серверу по адресу $serverUrl" -ForegroundColor Red
    exit 1
}

# Проверка LLM модели
$llmModel = "qwen2.5-coder:7b-instruct-q6_K"
$llmPrompt = "Объясни, как работает Retrieval-Augmented Generation (RAG)."
$llmPayload = @{
    model = $llmModel
    prompt = $llmPrompt
    stream = $false
} | ConvertTo-Json -Depth 3

Write-Host "`n🧠 Запрос к LLM модели '$llmModel'..." -ForegroundColor Cyan
try {
    $llmResponse = Invoke-RestMethod -Uri "$serverUrl/api/generate" -Method Post -Body $llmPayload -ContentType "application/json"
    Write-Host "📢 Ответ от LLM:" -ForegroundColor Green
    Write-Host $llmResponse.response
} catch {
    Write-Host "❌ Ошибка при запросе к LLM модели" -ForegroundColor Red
    Write-Host $_.Exception.Message
}

# Проверка Embedding модели
$embedModel = "mxbai-embed-large"
$embedPrompt = "Это пример текста, который нужно преобразовать в вектор."
$embedPayload = @{
    model = $embedModel
    prompt = $embedPrompt
} | ConvertTo-Json -Depth 3

Write-Host "`n🔷 Запрос к модели эмбеддингов '$embedModel'..." -ForegroundColor Cyan
try {
    $embedResponse = Invoke-RestMethod -Uri "$serverUrl/api/embeddings" -Method Post -Body $embedPayload -ContentType "application/json"
    Write-Host "📊 Получен эмбеддинг длиной $($embedResponse.embedding.Count)" -ForegroundColor Green
} catch {
    Write-Host "❌ Ошибка при запросе к embedding модели" -ForegroundColor Red
    Write-Host $_.Exception.Message
}
