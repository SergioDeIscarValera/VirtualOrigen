using Newtonsoft.Json;

namespace PropertyWeatherService.Models;

public class Property
{
    [property: JsonProperty("id")]
    public string Id { get; private set; }
    [property: JsonProperty("name")]
    public string Name { get; private set; }
    [property: JsonProperty("location")]
    public string Location { get; private set; }

    [JsonConstructor]
    public Property(string id, string name, string location)
    {
        Id = id;
        Name = name;
        Location = location;
    }

    public Property(Dictionary<string, object> data)
    {
        Id = data["id"] as string;
        Name = data["name"] as string;
        Location = data["location"] as string;
    }
}
