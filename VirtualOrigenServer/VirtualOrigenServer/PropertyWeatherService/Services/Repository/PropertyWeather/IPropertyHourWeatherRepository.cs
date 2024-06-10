using PropertyWeatherService.Models;

namespace PropertyWeatherService.Services.Repository.PropertyWeather;

internal interface IPropertyHourWeatherRepository : IRepository<PropertyHourWeather, DateTime, string>
{
    public Task<IEnumerable<PropertyHourWeather>> SaveAllAsync(IEnumerable<PropertyHourWeather> list, string idc);
}
