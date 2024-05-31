using Google.Cloud.Firestore;
using Newtonsoft.Json;

namespace InversorYesterdayService.Models;

[FirestoreData]
public class InversorData
{
    [FirestoreProperty(name: "battery")]
    [property: JsonProperty("battery")]
    public int Battery { get; private set; }

    [FirestoreProperty(name: "consumption")]
    [property: JsonProperty("consumption")]
    public int Consumption { get; private set; }

    [FirestoreProperty(name: "gain")]
    [property: JsonProperty("gain")]
    public int Gain { get; private set; }

    [FirestoreProperty(name: "datetime")]
    [property: JsonProperty("datetime")]
    public string DateTime { get; private set; }

    [JsonConstructor]
    public InversorData(int battery, int consumption, int gain, string datetime)
    {
        Battery = battery;
        Consumption = consumption;
        Gain = gain;
        DateTime = System.DateTime.Parse(datetime).ToString("yyyy-MM-dd HH:mm");
    }

    public InversorData()
    {
        Battery = 0;
        Consumption = 0;
        Gain = 0;
        DateTime = "2000-01-01 00:00";
    }

    public InversorData(Dictionary<string, object> data)
    {
        Battery = int.Parse(data["battery"].ToString());
        Consumption = int.Parse(data["consumption"].ToString());
        Gain = int.Parse(data["gain"].ToString());
        DateTime = data["datetime"].ToString();
    }

    public DateTime GetDateTime() => System.DateTime.Parse(DateTime);

    override public string ToString()
    {
        return $"{DateTime}:{Consumption},{Battery},{Gain}";
    }
}
