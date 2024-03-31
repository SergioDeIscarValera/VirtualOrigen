using PropertyWeatherService.Models;

namespace PropertyWeatherService.Services.Rest.Weather;

public class OpenWeatherRest
{
    private readonly MyHttpClient _httpClient;
    private readonly string _apiKey;

    private OpenWeatherRest()
    {
        _httpClient = MyHttpClient.Instance;
        _apiKey = "159615abd47311b634124524fcbd977a";
        //_apiKey = Environment.GetEnvironmentVariable("OPEN_WEATHER_API_KEY") ?? throw new("OPEN_WEATHER_API_KEY");
    }

    private static OpenWeatherRest? _instance;

    public static OpenWeatherRest Instance
    {
        get
        {
            _instance ??= new OpenWeatherRest();
            return _instance;
        }
    }

    public async Task<OpenWeatherDto?> GetWeatherAsync(double lat, double lon)
    {
        var request = $"forecast?lat={lat}&lon={lon}&units=metric&lang=es";
        return await _httpClient.GetAsync<OpenWeatherDto>($"{request}&appid={_apiKey}");
    }
}
