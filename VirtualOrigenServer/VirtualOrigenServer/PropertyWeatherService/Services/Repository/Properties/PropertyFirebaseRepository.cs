using Google.Cloud.Firestore;
using PropertyWeatherService.Models;
using PropertyWeatherService.Services.Db;

namespace PropertyWeatherService.Services.Repository.Properties;

internal class PropertyFirebaseRepository : IPropertyRepository
{
    private readonly CollectionReference collection;
    private readonly string _collectionName = "property";
    private readonly string _listName = "properties";

    public PropertyFirebaseRepository()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
    }

    private static PropertyFirebaseRepository? _instance;

    public static PropertyFirebaseRepository Instance
    {
        get
        {
            _instance ??= new PropertyFirebaseRepository();
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

    private async Task<List<Property>?> GetListAsync(string idc)
    {
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            return null;
        }
        var data = snapshot.ToDictionary();
        var jsonList = data[_listName] as List<object>;
        return jsonList.Select(x => new Property(x as Dictionary<string, object>)).ToList();
    }

    public async Task<bool> ExistsAsync(string id, string idc)
    {
        return await GetByIdAsync(id, idc) != null;
    }

    public async Task<IEnumerable<Property>> GetAllAsync(string idc)
    {
        return (await GetListAsync(idc)) ?? [];
    }

    public async Task<Property?> GetByIdAsync(string id, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null)
        {
            return null;
        }
        return list.Find(x => x.Id == id);
    }

    public async Task<List<Property>> GetUltraAllAsync()
    {
        // 1 - Get all IDCs
        var idcs = await collection.ListDocumentsAsync().Select(x => x.Id).ToListAsync();
        // 2 - Get all properties from all IDCs
        var properties = new List<Property>();
        foreach (var idc in idcs)
        {
            var list = await GetListAsync(idc);
            if (list == null)
            {
                continue;
            }
            properties.AddRange(list);
        }
        return properties;
    }
}
