using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.UserSecrets;

namespace PAssistant.Settings

{
    public class AppSettings
    {   
        public required GeneralSettings General { get; set; }
        public required OllamaSettings Ollama { get; set; }
        public required JiraSettings Jira { get; set; }

        private static AppSettings _current;

        public static AppSettings Current => _current ??= Load(); // Ленивая инициализация

        private static AppSettings Load(string configFile = "appsettings.json")
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile(configFile)        // Загружаем настройки из файла appsettings.json
                .AddUserSecrets<AppSettings>()  // Добавляем user-secrets
                .Build();               

            var settings = new AppSettings
            {
                General = new GeneralSettings(),
                Ollama  = new OllamaSettings(),
                Jira    = new JiraSettings()

            };
            configuration.Bind(settings);

            return settings;
        }
    }
}
