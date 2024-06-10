using Google.Cloud.Firestore;
using SmartDevicesService.Models;
using SmartDevicesService.Services.Db;

namespace SmartDevicesService.Services.Repository.InversorNow;

public class InversorNowFirebaseRepository : IInversorNow
{
    private readonly CollectionReference collection;
    private readonly string _collectionName = "inversor_now";

    public InversorNowFirebaseRepository()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
    }

    private static InversorNowFirebaseRepository? _instance;

    public static InversorNowFirebaseRepository Instance
    {
        get
        {
            _instance ??= new InversorNowFirebaseRepository();
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

    public async Task<InversorData?> GetByIdcAsync(string idc)
    {
        var snapshot = await GetSnapshotAsync(idc);
        if (snapshot == null)
        {
            return null;
        }
        var data = snapshot.ToDictionary();
        return new InversorData(data);
    }
}
