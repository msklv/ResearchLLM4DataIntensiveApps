using Microsoft.Extensions.Configuration;

namespace PAssistant.Settings

{
    public class AppSettings
    {
        public required OllamaSettings Ollama { get; set; }
        public required JiraSettings Jira { get; set; }

        private static AppSettings _current;

        public static AppSettings Current => _current ??= Load(); // Ленивая инициализация

        private static AppSettings Load(string configFile = "appsettings.json")
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile(configFile)
                .Build();

            var settings = new AppSettings
            {
                Ollama = new OllamaSettings(),
                Jira = new JiraSettings()
            };
            configuration.Bind(settings);

            return settings;
        }
    }
}
