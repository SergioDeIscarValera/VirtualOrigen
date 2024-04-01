import 'package:flutter/material.dart';

class PropertyHourWeather {
  final DateTimeRange dateTime;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final int humidity;
  final int clouds;
  final double windSpeed;
  final double rainProbability;
  final WeatherType weather;
  final String weatherIconUrl;

  PropertyHourWeather(
      {required this.dateTime,
      required this.temperature,
      required this.temperatureMin,
      required this.temperatureMax,
      required this.humidity,
      required this.clouds,
      required this.windSpeed,
      required this.rainProbability,
      required this.weather,
      required this.weatherIconUrl});

  PropertyHourWeather.defaultConstructor()
      : dateTime = DateTimeRange(start: DateTime.now(), end: DateTime.now()),
        temperature = 0,
        temperatureMin = 0,
        temperatureMax = 0,
        humidity = 0,
        clouds = 0,
        windSpeed = 0,
        rainProbability = 0,
        weather = WeatherType.values[0],
        weatherIconUrl = "";
}

enum WeatherType {
  THUNDERSTORM,
  DRIZZLE,
  RAIN,
  SNOW,
  ATMOSPHERE,
  CLEAR,
  CLOUDS
}

extension WeatherTypeExtension on WeatherType {
  String get token {
    switch (this) {
      case WeatherType.THUNDERSTORM:
        return "thunderstorm";
      case WeatherType.DRIZZLE:
        return "drizzle";
      case WeatherType.RAIN:
        return "rain";
      case WeatherType.SNOW:
        return "snow";
      case WeatherType.ATMOSPHERE:
        return "atmosphere";
      case WeatherType.CLEAR:
        return "clear";
      case WeatherType.CLOUDS:
        return "clouds";
    }
  }
}
