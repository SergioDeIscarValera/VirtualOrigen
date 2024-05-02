using Google.Cloud.Firestore;
using InversorYesterdayService.Models;
using InversorYesterdayService.Services.Db;

namespace InversorYesterdayService.Services.Repository.Inversor;

public class InversorDataRepository : IInversorDataRepository
{
    private readonly CollectionReference collection;
    private readonly string _collectionName = "inversor_yesterday";
    private readonly string _listName = "data";

    public InversorDataRepository()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
    }

    private static InversorDataRepository? _instance;

    public static InversorDataRepository Instance
    {
        get
        {
            _instance ??= new InversorDataRepository();
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

    private async Task<List<InversorData>?> GetListAsync(string idc)
    {
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            return null;
        }
        var data = snapshot.ToDictionary();
        var jsonList = data[_listName] as List<object>;
        return jsonList.Select(x => new InversorData(x as Dictionary<string, object>)).ToList();
    }

    public async Task DeleteAllAsync(string idc)
    {
        throw new NotImplementedException();
    }

    public async Task DeleteAsync(DateTime id, string idc)
    {
        var list = await GetListAsync(idc);
        if (list == null || list.Count == 0)
        {
            return;
        }
        list.RemoveAll(x => x.GetDateTime() == id);
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

    public async Task<bool> ExistsAsync(DateTime id, string idc)
    {
        return await GetByIdAsync(id, idc) != null;
    }

    public async Task<IEnumerable<InversorData>> GetAllAsync(string idc)
    {
        return (await GetListAsync(idc)) ?? [];
    }

    public async Task<InversorData?> GetByIdAsync(DateTime id, string idc)
    {
        return (await GetListAsync(idc))?.Find(x => x.GetDateTime() == id);
    }

    public async Task<InversorData> SaveAsync(InversorData entity, string idc)
    {
        var list = (await GetListAsync(idc)) ?? [];
        var index = list.FindIndex(x => x.GetDateTime() == entity.GetDateTime());
        if (index != -1)
        {
            list[index] = entity;
        }
        else
        {
            list.Add(entity);
        }

        LimitList(list);

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

    private static void LimitList(List<InversorData> list)
    {
        var now = DateTime.Now;
        var limit = now.AddDays(-15);
        list.RemoveAll(x => x.GetDateTime() < limit);
    }
}
