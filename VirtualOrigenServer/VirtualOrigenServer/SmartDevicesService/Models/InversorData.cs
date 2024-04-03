using Google.Cloud.Firestore;
using Newtonsoft.Json;

namespace SmartDevicesService.Models;

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

    [JsonConstructor]
    public InversorData(int battery, int consumption, int gain)
    {
        Battery = battery;
        Consumption = consumption;
        Gain = gain;
    }

    public InversorData(Dictionary<string, object> data)
    {
        Battery = (int)data["battery"];
        Consumption = (int)data["consumption"];
        Gain = (int)data["gain"];
    }

    public InversorData()
    {
        Battery = 0;
        Consumption = 0;
        Gain = 0;
    }

    override public string ToString()
    {
        return $"{Consumption},{Battery},{Gain}";
    }
}
