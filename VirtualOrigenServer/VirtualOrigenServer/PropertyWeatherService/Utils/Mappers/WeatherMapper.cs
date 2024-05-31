using PropertyWeatherService.Models;

namespace PropertyWeatherService.Utils.Mappers;

public class WeatherMapper
{
    private WeatherMapper()
    {
    }

    public static WeatherMapper? _instance;

    public static WeatherMapper Instance
    {
        get
        {
            _instance ??= new WeatherMapper();
            return _instance;
        }
    }

    public List<PropertyHourWeather> MapFromOpenWeather(OpenWeatherDto openWeather)
    {
        var propertyHourWeathers = new List<PropertyHourWeather>();
        foreach (var item in openWeather.list)
        {
            propertyHourWeathers.Add(
                new PropertyHourWeather(
                    dateTime: DateTime.Parse(item.dt_txt).AddHours(-3).ToString("yyyy-MM-dd HH:mm:ss"),
                    dateTimeEnd: item.dt_txt,
                    temperature: item.main.temp,
                    temperatureMin: item.main.temp_min,
                    temperatureMax: item.main.temp_max,
                    humidity: item.main.humidity,
                    clouds: item.clouds.all,
                    windSpeed: item.wind.speed,
                    rainProbability: item.pop,
                    weatherType: item.weather[0].main,
                    weatherIconUrl: $"https://openweathermap.org/img/wn/{item.weather[0].icon}@2x.png"
                )
            );
        }
        return propertyHourWeathers;
    }
}
