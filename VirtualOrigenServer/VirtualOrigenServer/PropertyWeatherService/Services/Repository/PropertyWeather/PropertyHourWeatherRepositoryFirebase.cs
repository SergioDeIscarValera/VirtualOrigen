using Google.Cloud.Firestore;
using PropertyWeatherService.Models;
using PropertyWeatherService.Services.Db;

namespace PropertyWeatherService.Services.Repository.PropertyWeather;

internal class PropertyHourWeatherRepositoryFirebase : IPropertyHourWeatherRepository
{
    private readonly CollectionReference collection;
    private readonly string _collectionName = "property_day_weather";
    private readonly string _listName = "weathers";

    public PropertyHourWeatherRepositoryFirebase()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
    }

    private static PropertyHourWeatherRepositoryFirebase? _instance;

    public static PropertyHourWeatherRepositoryFirebase Instance
    {
        get
        {
            _instance ??= new PropertyHourWeatherRepositoryFirebase();
            return _instance;
        }
    }

    private async Task<DocumentSnapshot?> GetSnapshotAsync(string idc)
    {
        DocumentReference document = collection.Document(idc);
        DocumentSnapshot snapshot = await document.GetSnapshotAsync();
        if (!snapshot.Exists)
        {
            return null;
        }
        return snapshot;
    }

    private async Task<List<PropertyHourWeather>?> GetListAsync(string idc)
    {
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            return null;
        }
        return snapshot.GetValue<List<PropertyHourWeather>>(_listName);
    }

    public Task DeleteAllAsync(string idc)
    {
        DocumentReference document = collection.Document(idc);
        return document.DeleteAsync();
    }

    public async Task DeleteAsync(DateTime id, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null || list.Count == 0)
        {
            return;
        }
        // Is between x.DateTime and x.DateTimeEnd
        list.RemoveAll(x => id.Ticks >= x.DateTimeDate.Ticks && id.Ticks <= x.DateTimeEndDate.Ticks);
    }

    public async Task<bool> ExistsAsync(DateTime id, string idc)
    {
        return await GetByIdAsync(id, idc) != null;
    }

    public async Task<IEnumerable<PropertyHourWeather>> GetAllAsync(string idc)
    {
        return (await GetListAsync(idc)) ?? [];
    }

    public async Task<PropertyHourWeather?> GetByIdAsync(DateTime id, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null)
        {
            return null;
        }
        return list.Find(x => id.Ticks >= x.DateTimeDate.Ticks && id.Ticks <= x.DateTimeEndDate.Ticks);
    }

    public async Task<PropertyHourWeather> SaveAsync(PropertyHourWeather entity, string idc)
    {
        var list = await GetListAsync(idc) ?? [];
        if (await ExistsAsync(entity.DateTimeDate, idc))
        {
            list.RemoveAll(x => entity.DateTimeDate.Ticks >= x.DateTimeDate.Ticks && entity.DateTimeDate.Ticks <= x.DateTimeEndDate.Ticks);
        }
        list.Add(entity);
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            await collection.Document(idc).SetAsync(new Dictionary<string, object>
            {
                {_listName, list}
            });
        }
        else
        {
            await snapshot.Reference.UpdateAsync(new Dictionary<string, object>
            {
                {_listName, list}
            });
        }
        return entity;
    }

    public async Task<IEnumerable<PropertyHourWeather>> SaveAllAsync(IEnumerable<PropertyHourWeather> list, string idc)
    {
        await DeleteAllAsync(idc);
        foreach (var item in list)
        {
            await SaveAsync(item, idc);
        }
        return list;
    }
}