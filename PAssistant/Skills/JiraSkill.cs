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
            var response = await _httpClient.GetAsync($"{_settings.Url}/rest/api/2/search?jql=assignee={assignee}");
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync();
            var document = JsonDocument.Parse(json);
            var issues = document.RootElement.GetProperty("issues");

            return string.Join("\n", issues.EnumerateArray()
                .Select(i => $"{i.GetProperty("key").GetString()}: {i.GetProperty("fields").GetProperty("summary").GetString()}"));
        }
    }
}
