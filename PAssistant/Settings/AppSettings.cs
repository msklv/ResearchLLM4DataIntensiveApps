using Microsoft.Extensions.Configuration;

namespace PAssistant.Settings

{
    public class AppSettings
    {
        public OllamaSettings Ollama { get; set; }
        public JiraSettings Jira { get; set; }

        private static AppSettings _current;

        public static AppSettings Current => _current ??= Load();

        private static AppSettings Load(string configFile = "appsettings.json")
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile(configFile)
                .Build();

            var settings = new AppSettings();
            configuration.Bind(settings);

            return settings;
        }
    }
}
