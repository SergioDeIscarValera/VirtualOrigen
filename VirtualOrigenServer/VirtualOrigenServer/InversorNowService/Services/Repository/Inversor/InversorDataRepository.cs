using Google.Cloud.Firestore;
using InversorNowService.Models;
using InversorNowService.Services.Db;

namespace InversorNowService.Services.Repository.Inversor;

public class InversorDataRepository
{
    private readonly CollectionReference collection;
    private const string _collectionName = "inversor_now";
    private string _documentId;

    public InversorDataRepository()
    {
        var db = MyFirebaseDb.Instance;
        collection = db.Db.Collection(_collectionName);
        _documentId = Environment.GetEnvironmentVariable("DOCUMENT_ID") ?? throw new("DOCUMENT_ID");
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

    public async Task<InversorData> SaveAsync(InversorData data)
    {
        var doc = collection.Document(_documentId);
        await doc.SetAsync(data);
        return data;
    }
}
