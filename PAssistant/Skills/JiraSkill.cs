using Microsoft.SemanticKernel;
using PAssistant.Settings;
using System.Net.Http.Headers;
using System.Text.Json;

namespace PAssistant.Skills

{
    public class JiraSkill
    {
        private readonly JiraSettings _settings;
        private readonly HttpClient _httpClient;

        public JiraSkill(JiraSettings settings)
        {
            _settings = settings;
            _httpClient = new HttpClient();
            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", _settings.AuthToken);
        }

        [KernelFunction("GetMyIssues")]
        public async Task<string> GetMyIssuesAsync(string assignee)
        {
            // Отправляет HTTP GET запрос для получения задач, назначенных указанному исполнителю из Jira
            var response = await _httpClient.GetAsync($"{_settings.Url}/rest/api/2/search?jql=assignee={assignee}");

            // Проверяет успешность запроса
            response.EnsureSuccessStatusCode();

            // Читает содержимое ответа в виде строки JSON
            var json = await response.Content.ReadAsStringAsync();

            // Парсит строку JSON в документ JSON
            var document = JsonDocument.Parse(json);

            // Получает раздел "issues" из документа JSON
            var issues = document.RootElement.GetProperty("issues");

            // Преобразует список задач в строку, где каждая задача представлена как "ключ: краткое описание"
            return string.Join("\n", issues.EnumerateArray()
                .Select(i => $"{i.GetProperty("key").GetString()}: {i.GetProperty("fields").GetProperty("summary").GetString()}"));
        }
    }
}
