using Google.Cloud.Firestore;
using System.Text.Json.Serialization;

namespace PropertyWeatherService.Models;

[FirestoreData]
public class PropertyHourWeather
{
    [FirestoreProperty(name: "dateTime")]
    [property: JsonPropertyName("dateTime")]
    public string DateTimeStart { get; private set; }

    [FirestoreProperty(name: "dateTimeEnd")]
    [property: JsonPropertyName("dateTimeEnd")]
    public string DateTimeEnd { get; private set; }

    [FirestoreProperty(name: "tem")]
    [property: JsonPropertyName("tem")]
    public double Temperature { get; private set; }

    [FirestoreProperty(name: "temMin")]
    [property: JsonPropertyName("temMin")]
    public double TemperatureMin { get; private set; }

    [FirestoreProperty(name: "temMax")]
    [property: JsonPropertyName("temMax")]
    public double TemperatureMax { get; private set; }

    [FirestoreProperty(name: "hum")]
    [property: JsonPropertyName("hum")]
    public int Humidity { get; private set; }

    [FirestoreProperty(name: "clouds")]
    [property: JsonPropertyName("clouds")]
    public int Clouds { get; private set; }

    [FirestoreProperty(name: "windSpeed")]
    [property: JsonPropertyName("windSpeed")]
    public double WindSpeed { get; private set; }

    [FirestoreProperty(name: "rainProbab")]
    [property: JsonPropertyName("rainProbab")]
    public double RainProbability { get; private set; }

    [FirestoreProperty(name: "weather")]
    [property: JsonPropertyName("weather")]
    public string WeatherType { get; private set; }

    [FirestoreProperty(name: "weatherIconUrl")]
    [property: JsonPropertyName("weatherIconUrl")]
    public string WeatherIconUrl { get; private set; }

    [JsonConstructor]
    public PropertyHourWeather(string dateTime, string dateTimeEnd, double temperature, double temperatureMin, double temperatureMax, int humidity, int clouds, double windSpeed, double rainProbability, string weatherType, string weatherIconUrl)
    {
        DateTimeStart = dateTime;
        DateTimeEnd = dateTimeEnd;
        Temperature = temperature;
        TemperatureMin = temperatureMin;
        TemperatureMax = temperatureMax;
        Humidity = humidity;
        Clouds = clouds;
        WindSpeed = windSpeed;
        RainProbability = rainProbability;
        WeatherType = weatherType.ToLower();
        WeatherIconUrl = weatherIconUrl;
    }

    public PropertyHourWeather()
    {

    }

    public DateTime DateTimeDate => DateTime.Parse(DateTimeStart);
    public DateTime DateTimeEndDate => DateTime.Parse(DateTimeEnd);
}