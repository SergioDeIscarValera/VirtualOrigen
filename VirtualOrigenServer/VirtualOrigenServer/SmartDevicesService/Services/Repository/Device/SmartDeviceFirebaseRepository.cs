using Google.Cloud.Firestore;
using SmartDevicesService.Models;
using SmartDevicesService.Services.Db;

namespace SmartDevicesService.Services.Repository.Device;

internal class SmartDeviceFirebaseRepository : ISmartDeviceRepository
{
    private readonly CollectionReference collection;
    private readonly string _collectionName = "smart_device";
    private readonly string _listName = "smart_devices";

    public SmartDeviceFirebaseRepository()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
    }

    private static SmartDeviceFirebaseRepository? _instance;

    public static SmartDeviceFirebaseRepository Instance
    {
        get
        {
            _instance ??= new SmartDeviceFirebaseRepository();
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

    private async Task<List<SmartDevice>?> GetListAsync(string idc)
    {
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            return null;
        }
        var data = snapshot.ToDictionary();
        var jsonList = data[_listName] as List<object>;
        return jsonList.Select(x => new SmartDevice(x as Dictionary<string, object>)).ToList();
    }

    public async Task DeleteAllAsync(string idc)
    {
        throw new NotImplementedException();
    }

    public async Task DeleteAsync(string id, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null || list.Count == 0)
        {
            return;
        }
        list.RemoveAll(x => x.Id == id);
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            await collection.Document(idc).SetAsync(new Dictionary<string, object>
            {
                { _listName, list }
            });
        }
        else
        {
            await snapshot.Reference.SetAsync(new Dictionary<string, object>
            {
                { _listName, list }
            });
        }
    }

    public async Task<bool> ExistsAsync(string id, string idc)
    {
        return await GetByIdAsync(id, idc) != null;
    }

    public async Task<IEnumerable<SmartDevice>> GetAllAsync(string idc)
    {
        return (await GetListAsync(idc)) ?? new();
    }

    public async Task<SmartDevice?> GetByIdAsync(string id, string idc)
    {
        return (await GetListAsync(idc))?.Find(x => x.Id == id);
    }

    public async Task<SmartDevice> SaveAsync(SmartDevice entity, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null)
        {
            list = new();
        }
        var index = list.FindIndex(x => x.Id == entity.Id);
        if (index != -1)
        {
            list[index] = entity;
        }
        else
        {
            list.Add(entity);
        }
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            await collection.Document(idc).SetAsync(new Dictionary<string, object>
            {
                { _listName, list }
            });
        }
        else
        {
            await snapshot.Reference.SetAsync(new Dictionary<string, object>
            {
                { _listName, list }
            });
        }
        return entity;
    }
}
