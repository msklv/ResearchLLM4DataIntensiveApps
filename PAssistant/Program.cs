#pragma warning disable SKEXP0070 // SKEXP0070: The assembly 'Microsoft.SemanticKernel' is referenced by the project but not used in the code


using Microsoft.SemanticKernel;
using PAssistant.Settings;
using PAssistant.Skills;
using Microsoft.SemanticKernel.Connectors.Ollama;
using Microsoft.SemanticKernel.ChatCompletion;

var settings = AppSettings.Current;         // Получаем настройки из конфигурации

var builder = Kernel.CreateBuilder();       // Создаем билдер для ядра

// Подключаем Ollama 
builder.AddOllamaChatCompletion(
    modelId: settings.Ollama.Model, // Идентификатор модели
    endpoint: new Uri(settings.Ollama.Endpoint),
    serviceId: "ollama" // Идентификатор сервиса
); 


var kernel = builder.Build(); // Создаем ядро

// Подключаем jira
var jiraSkill = new JiraSkill(settings.Jira);     // Создаем скилл Jira
kernel.ImportPluginFromObject(jiraSkill, "jira"); // Импортируем плагин Jira


var chatCompletionService = kernel.GetRequiredService<IChatCompletionService>(); // Получаем сервис для чата
var chatSettings = new OllamaPromptExecutionSettings { FunctionChoiceBehavior = FunctionChoiceBehavior.Auto() };

Console.WriteLine("""
    Ask questions or give instructions to the copilot such as:
    - Change the alarm to 8
    - What is the current alarm set?
    - Is the light on?
    - Turn the light off please.
    - Set an alarm for 6:00 am.
    """);

Console.Write("> ");

string? input = null;
while ((input = Console.ReadLine()) is not null)
{
    Console.WriteLine();

    try
    {
        ChatMessageContent chatResult = await chatCompletionService.GetChatMessageContentAsync(input, chatSettings, kernel);
        Console.Write($"\n>>> Result: {chatResult}\n\n> ");
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error: {ex.Message}\n\n> ");
    }
}