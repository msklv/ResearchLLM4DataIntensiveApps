using System.Net.Http;
using System.Text.Json;
using PAssistant.Settings;

namespace PAssistant.Validators;


public static class StartupValidator
{
    public static async Task ValidateAsync(AppSettings settings)
    {
        await ValidateOllamaAsync(settings.Ollama);
        // Добавь другие проверки здесь
    }

    private static async Task ValidateOllamaAsync(OllamaSettings ollama)
    {
        using var http = new HttpClient();

        // Проверяем доступность эндпоинта
        try
        {
            var response = await http.GetAsync($"{ollama.Endpoint}/api/tags");
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var data = JsonDocument.Parse(json);
            var models = data.RootElement.GetProperty("models");

            bool modelFound = models.EnumerateArray()
                .Any(m => m.GetProperty("name").GetString() == ollama.Model);

            if (!modelFound)
            {
                throw new Exception($"Модель '{ollama.Model}' не найдена на Ollama-сервере.");
            }
        }
        catch (Exception ex)
        {
            throw new Exception($"Ошибка проверки Ollama эндпоинта '{ollama.Endpoint}': {ex.Message}");
        }
    }
}