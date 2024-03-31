using System.Text;
using System.Text.Json;

namespace PropertyWeatherService.Services.Rest;

public class MyHttpClient
{
    private readonly HttpClient _httpClient;

    private MyHttpClient()
    {
        _httpClient = new HttpClient();
        var urlBase = "https://api.openweathermap.org/data/2.5/";
        _httpClient.BaseAddress = new Uri(urlBase);
    }

    private static MyHttpClient? _instance;

    public static MyHttpClient Instance
    {
        get
        {
            _instance ??= new MyHttpClient();
            return _instance;
        }
    }

    public async Task<T?> GetAsync<T>(string requestUri)
    {
        try
        {
            var response = await _httpClient.GetAsync(requestUri);
            response.EnsureSuccessStatusCode();
            var content = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<T>(content);
        }
        catch (JsonException _)
        {
            return default;
        }
    }

    public async Task<T?> PostAsync<T>(string requestUri, T content)
    {
        try
        {
            var json = JsonSerializer.Serialize(content);
            var response = await _httpClient.PostAsync(requestUri, new StringContent(json, Encoding.UTF8, "application/json"));
            response.EnsureSuccessStatusCode();
            var responseContent = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<T>(responseContent);
        }
        catch (JsonException _)
        {
            return default;
        }
    }

    public async Task<T?> PutAsync<T>(string requestUri, T content)
    {
        try
        {
            var json = JsonSerializer.Serialize(content);
            var response = await _httpClient.PutAsync(requestUri, new StringContent(json, Encoding.UTF8, "application/json"));
            response.EnsureSuccessStatusCode();
            var responseContent = await response.Content.ReadAsStringAsync();
            return JsonSerializer.Deserialize<T>(responseContent);
        }
        catch (JsonException _)
        {
            return default;
        }
    }

    public async Task<bool> DeleteAsync(string requestUri)
    {
        try
        {
            var response = await _httpClient.DeleteAsync(requestUri);
            response.EnsureSuccessStatusCode();
            return true;
        }
        catch (Exception _)
        {
            return false;
        }
    }
}
