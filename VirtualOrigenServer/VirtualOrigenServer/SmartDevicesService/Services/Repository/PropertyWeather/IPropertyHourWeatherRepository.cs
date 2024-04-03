using SmartDevicesService.Models;

namespace SmartDevicesService.Services.Repository.PropertyWeather;

public interface IPropertyHourWeatherRepository : IRepository<PropertyHourWeather, DateTime, string>
{
    public Task<IEnumerable<PropertyHourWeather>> SaveAllAsync(IEnumerable<PropertyHourWeather> list, string idc);
}
