#pragma warning disable SKEXP0070 // SKEXP0070: The assembly 'Microsoft.SemanticKernel' is referenced by the project but not used in the code


using Microsoft.SemanticKernel;
using PAssistant.Settings;
using PAssistant.Skills;
using Microsoft.SemanticKernel.ChatCompletion;


var settings = AppSettings.Current;

var builder = Kernel.CreateBuilder();

// Подключаем Ollama
builder.AddOllamaChatCompletion(
    modelId: settings.Ollama.Model,
    endpoint: new Uri(settings.Ollama.Endpoint)
); 

// Создаем ядро
var kernel = builder.Build();

// Подключаем jira
// Создаем настройки для Jira

var jiraSkill = new JiraSkill(settings.Jira);
kernel.ImportPluginFromObject(jiraSkill, "jira");

// Создаем чат
