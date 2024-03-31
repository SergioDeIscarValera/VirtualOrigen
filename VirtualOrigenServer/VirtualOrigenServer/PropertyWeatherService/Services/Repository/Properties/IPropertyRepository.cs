namespace PropertyWeatherService.Services.Repository.Properties;

internal interface IPropertyRepository : IRepositoryOnlyGet<Models.Property, string, string>
{
    public Task<List<Models.Property>> GetUltraAllAsync();
}
