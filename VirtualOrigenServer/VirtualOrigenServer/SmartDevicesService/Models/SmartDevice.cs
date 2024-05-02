using Google.Cloud.Firestore;
using System.Text.Json.Serialization;

namespace SmartDevicesService.Models;

[FirestoreData]
public class SmartDevice
{
    [FirestoreProperty(name: "id")]
    [property: JsonPropertyName("id")]
    public string Id { get; private set; }

    [FirestoreProperty(name: "name")]
    [property: JsonPropertyName("name")]
    public string Name { get; private set; }

    [FirestoreProperty(name: "timeZones")]
    [property: JsonPropertyName("timeZones")]
    public List<string> TimeZones { get; private set; }

    [FirestoreProperty(name: "days")]
    [property: JsonPropertyName("days")]
    public List<bool> Days { get; private set; }

    [FirestoreProperty(name: "batteryRange")]
    [property: JsonPropertyName("batteryRange")]
    public string? BatteryRange { get; private set; }

    [FirestoreProperty(name: "productionRange")]
    [property: JsonPropertyName("productionRange")]
    public string? ProductionRange { get; private set; }

    [FirestoreProperty(name: "consumptionRange")]
    [property: JsonPropertyName("consumptionRange")]
    public string? ConsumptionRange { get; private set; }

    [FirestoreProperty(name: "temperatureRange")]
    [property: JsonPropertyName("temperatureRange")]
    public string? TemperatureRange { get; private set; }

    [FirestoreProperty(name: "rainRange")]
    [property: JsonPropertyName("rainRange")]
    public string? RainRange { get; private set; }

    [FirestoreProperty(name: "isManualMode")]
    [property: JsonPropertyName("isManualMode")]
    public bool IsManualMode { get; private set; }

    [FirestoreProperty(name: "isOn")]
    [property: JsonPropertyName("isOn")]
    public bool IsOn { get; private set; }

    [JsonConstructor]
    public SmartDevice(string id, string name, List<string> timeZones, List<bool> days, bool isManualMode, bool isOn, string? batteryRange = null, string? productionRange = null, string? consumptionRange = null, string? temperatureRange = null, string? rainRange = null)
    {
        Id = id;
        Name = name;
        TimeZones = timeZones;
        Days = days;
        BatteryRange = batteryRange;
        ProductionRange = productionRange;
        ConsumptionRange = consumptionRange;
        TemperatureRange = temperatureRange;
        RainRange = rainRange;
        IsManualMode = isManualMode;
        IsOn = isOn;
    }

    public SmartDevice(Dictionary<string, object> data)
    {
        Id = data["id"] as string ?? "";
        Name = data["name"] as string ?? "";
        TimeZones = ((List<object>)data["timeZones"]).Cast<string>().ToList() ?? [];
        Days = ((List<object>)data["days"]).Cast<bool>().ToList() ?? [];
        BatteryRange = data.TryGetValue("batteryRange", out object? value) ? value as string : null;
        ProductionRange = data.TryGetValue("productionRange", out value) ? value as string : null;
        ConsumptionRange = data.TryGetValue("consumptionRange", out value) ? value as string : null;
        TemperatureRange = data.TryGetValue("temperatureRange", out value) ? value as string : null;
        RainRange = data.ContainsKey("rainRange") ? data["rainRange"] as string : null;
        IsManualMode = data["isManualMode"] as bool? ?? false;
        IsOn = data["isOn"] as bool? ?? false;
    }

    public SmartDevice()
    {
        Id = "";
        Name = "";
        TimeZones = [];
        Days = [];
        BatteryRange = null;
        ProductionRange = null;
        ConsumptionRange = null;
        TemperatureRange = null;
        RainRange = null;
        IsManualMode = false;
        IsOn = false;
    }

    public void SetIsOn(bool isOn)
    {
        IsOn = isOn;
    }

    public Dictionary<string, object> keyValues()
    {
        var data = new Dictionary<string, object>
        {
            { "id", Id },
            { "name", Name },
            { "timeZones", TimeZones },
            { "days", Days },
            { "isManualMode", IsManualMode },
            { "isOn", IsOn }
        };
        if (BatteryRange != null)
        {
            data.Add("batteryRange", BatteryRange);
        }
        if (ProductionRange != null)
        {
            data.Add("productionRange", ProductionRange);
        }
        if (ConsumptionRange != null)
        {
            data.Add("consumptionRange", ConsumptionRange);
        }
        if (TemperatureRange != null)
        {
            data.Add("temperatureRange", TemperatureRange);
        }
        if (RainRange != null)
        {
            data.Add("rainRange", RainRange);
        }
        return data;
    }
}
