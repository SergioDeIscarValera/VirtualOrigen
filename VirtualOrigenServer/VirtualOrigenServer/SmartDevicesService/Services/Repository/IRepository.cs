namespace SmartDevicesService.Services.Repository;

public interface IRepository<T, ID, IDC> : IRepositoryOnlyGet<T, ID, IDC>
{
    public Task<T> SaveAsync(T entity, IDC idc);
    public Task DeleteAsync(ID id, IDC idc);
    public Task DeleteAllAsync(IDC idc);
}
