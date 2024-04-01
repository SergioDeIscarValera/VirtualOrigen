using Google.Apis.Auth.OAuth2;
using Google.Cloud.Firestore;
using Google.Cloud.Firestore.V1;

namespace InversorNowService.Services.Db;

public class MyFirebaseDb
{
    public FirestoreDb Db { get; private set; }
    private MyFirebaseDb()
    {
        string strWorkPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
        var credentials = GoogleCredential.FromFile(Path.Combine(strWorkPath, "firebase_credentials.json"));

        Db = FirestoreDb.Create("virtual-origen-tfg", new FirestoreClientBuilder
        {
            Credential = credentials
        }.Build());
    }

    private static MyFirebaseDb? _instance;

    public static MyFirebaseDb Instance
    {
        get
        {
            _instance ??= new MyFirebaseDb();
            return _instance;
        }
    }
}