using Newtonsoft.Json;

namespace PropertyWeatherService.Models;

public record City(
    int id,
    string name,
    Coord coord,
    string country,
    int population,
    int timezone,
    int sunrise,
    int sunset
);

public record Clouds(
    int all
);

public record Coord(
    double lat,
    double lon
);

public record List(
    int dt,
    Main main,
    IReadOnlyList<Weather> weather,
    Clouds clouds,
    Wind wind,
    int visibility,
    double pop,
    Rain rain,
    Sys sys,
    string dt_txt
);

public record Main(
    double temp,
    double feels_like,
    double temp_min,
    double temp_max,
    int pressure,
    int sea_level,
    int grnd_level,
    int humidity,
    double temp_kf
);

public record Rain(
    [property: JsonProperty("3h")] double _3h
);

public record OpenWeatherDto(
    string cod,
    int message,
    int cnt,
    IReadOnlyList<List> list,
    City city
);

public record Sys(
    string pod
);

public record Weather(
    int id,
    string main,
    string description,
    string icon
);

public record Wind(
    double speed,
    int deg,
    double gust
);