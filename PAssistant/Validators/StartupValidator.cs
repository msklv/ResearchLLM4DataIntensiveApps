using System.Net.Http;
using System.Text.Json;
using PAssistant.Settings;

namespace PAssistant.Validators;

public static class StartupValidator
{
    public static async Task ValidateAsync(AppSettings settings)
    {   
        // Проверяем настройки и готовность Ollama в цикле
        await ValidateOllamaAsync(settings.Ollama);

        // Проверяем настройки и готовность Jira в цикле
        await ValidateJiraAsync(settings.Jira);
    }

    private static async Task ValidateOllamaAsync(OllamaSettings ollama)
    {
        using var http = new HttpClient();
        bool success = false;
        int attempts = 0;
        const int maxAttempts = 3;

        // Проверка доступности Ollama и наличия модели в цикле
        while (!success && attempts < maxAttempts)
        {
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
                    Console.WriteLine($"Модель '{ollama.Model}' не найдена на Ollama-сервере.");
                }
                else
                {
                    success = true;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Ошибка проверки Ollama эндпоинта '{ollama.Endpoint}': {ex.Message}");
            }

            if (!success)
            {
                attempts++;
                if (attempts < maxAttempts)
                {
                    await Task.Delay(2000); // Таймаут 2 секунды
                }
            }
        }

        if (success)
        {
            Console.WriteLine($"Ollama-сервер '{ollama.Endpoint}' доступен и модель '{ollama.Model}' найдена.");
            Console.WriteLine("");
        }
        else
        {
            Console.WriteLine($"Не удалось проверить Ollama после {maxAttempts} попыток. Проверьте настройки.");
            Console.WriteLine("");
        }
    }

    private static async Task ValidateJiraAsync(JiraSettings jira)
    {
        using var http = new HttpClient();
        bool success = false;
        int attempts = 0;
        const int maxAttempts = 3;

        // Проверка доступности Jira в цикле
        while (!success && attempts < maxAttempts)
        {
            try
            {
                var response = await http.GetAsync($"{jira.Url}");
                response.EnsureSuccessStatusCode();
                success = true;
            }
            catch (HttpRequestException ex)
            {
                // Обработка исключения, если сервер недоступен или произошла ошибка сети
                Console.WriteLine($"Ошибка проверки Jira эндпоинта '{jira.Url}");
                Console.WriteLine($"Ошибка запроса: {ex.Message}");
            }
            catch (Exception ex)
            {
                // Обработка других исключений
                Console.WriteLine($"Ошибка проверки Jira эндпоинта '{jira.Url}': {ex.Message}");
            }

            if (!success)
            {
                attempts++;
                if (attempts < maxAttempts)
                {
                    await Task.Delay(2000); // Таймаут 2 секунды
                }
            }
        }

        if (success)
        {
            Console.WriteLine($"Jira-сервер '{jira.Url}' доступен.");
            Console.WriteLine("");
        }
        else
        {
            Console.WriteLine($"Не удалось проверить Jira после {maxAttempts} попыток. Проверьте настройки.");
            Console.WriteLine("");
        }
        
    }

}