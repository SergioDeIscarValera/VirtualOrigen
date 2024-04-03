using SmartDevicesService.Models;

namespace SmartDevicesService.Services.Repository.InversorNow;

public interface IInversorNow
{
    Task<InversorData?> GetByIdcAsync(string idc);
}
