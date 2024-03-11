using Google.Apis.Auth.OAuth2;
using Google.Cloud.Firestore;
using Google.Cloud.Firestore.V1;

Console.WriteLine("Init server...");

var credentials = GoogleCredential.FromFile("../../../ApiKey/firebase_credentials.json");

FirestoreDb db = FirestoreDb.Create("virtual-origen-tfg", new FirestoreClientBuilder
{
    Credential = credentials
}.Build());

CollectionReference collection = db.Collection("ejemplo");
DocumentReference document = collection.Document("ejemplo1");

DocumentSnapshot snapshot = await document.GetSnapshotAsync();

if (snapshot.Exists)
{
    var name = snapshot.GetValue<string>("nombre");
    Console.WriteLine(name);
}