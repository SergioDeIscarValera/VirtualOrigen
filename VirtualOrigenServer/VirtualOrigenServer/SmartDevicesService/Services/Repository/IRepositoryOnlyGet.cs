namespace SmartDevicesService.Services.Repository;

public interface IRepositoryOnlyGet<T, ID, IDC>
{
    public Task<T?> GetByIdAsync(ID id, IDC idc);
    public Task<IEnumerable<T>> GetAllAsync(IDC idc);
    public Task<bool> ExistsAsync(ID id, IDC idc);
}
