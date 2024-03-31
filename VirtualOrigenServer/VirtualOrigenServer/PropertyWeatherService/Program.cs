using PropertyWeatherService.Models;
using PropertyWeatherService.Services.Repository.Properties;
using PropertyWeatherService.Services.Repository.PropertyWeather;
using PropertyWeatherService.Services.Rest.Weather;
using PropertyWeatherService.Utils.Mappers;

Console.WriteLine("PropertyWeatherService v1.0");
IPropertyRepository propertyRepository = PropertyFirebaseRepository.Instance;
IPropertyHourWeatherRepository propertyHourWeatherRepository = PropertyHourWeatherRepositoryFirebase.Instance;
var openWeatherRest = OpenWeatherRest.Instance;
var weatherMapper = WeatherMapper.Instance;
// 1 -> Optener todas las propiedades de la base de datos
var properties = await propertyRepository.GetUltraAllAsync();
foreach (var property in properties)
{
    Console.WriteLine($"Property: {property.Id}");
}

// 2 -> Obtener la predicción climática para hoy de todas las propiedades
var weathers = new Dictionary<string, List<PropertyHourWeather>>();
var now = DateTime.Now;
foreach (var property in properties)
{
    var location = property.Location.Split(':').Select(x => double.Parse(x.Replace(".", ","))).ToArray();
    var openWeatherDto = await openWeatherRest.GetWeatherAsync(location[0], location[1]);
    weathers[property.Id] = weatherMapper.MapFromOpenWeather(openWeatherDto).Where(x => now.Day == x.DateTimeEndDate.Day && now.Month == x.DateTimeEndDate.Month).ToList();
}

// 3 -> Guardar la predicción climática para hoy de todas las propiedades
foreach (var item in weathers)
{
    await propertyHourWeatherRepository.SaveAllAsync(item.Value, item.Key);
}