import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_origen_app/models/property_day_weather.dart';
import 'package:virtual_origen_app/services/repository/gen_firebase/gen_firebase_repository_only_get.dart';

class PropertyDayWeatherFirebaseRepository
    extends GenFirebaseRepositoryOnlyGet<PropertyHourWeather, DateTime> {
  @override
  String get collectionName => "property_day_weather";

  @override
  String get idName => "dateTime";

  @override
  String get listName => "weathers";

  final Map<String, Function(PropertyHourWeather)> eventsListener = {};

  PropertyDayWeatherFirebaseRepository() {
    _startTimer();
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return PropertyHourWeather(
      dateTime: _dateTimeRangeFromStrings(json["dateTimeEnd"], json[idName]),
      temperature: json["tem"],
      temperatureMin: json["temMin"],
      temperatureMax: json["temMax"],
      humidity: json["hum"],
      clouds: json["clouds"],
      windSpeed: json["windSpeed"],
      rainProbability: json["rainProbab"] * 100,
      weather: WeatherType.values.firstWhere(
          (element) => element.token.toUpperCase() == json["weather"]),
      weatherIconUrl: json["weatherIconUrl"],
    );
  }

  @override
  Future<PropertyHourWeather?> findById({
    required DateTime id,
    required String idc,
  }) async {
    var docRef = await getRefAndSnapshot(idc: idc);
    if (checkIfDocExists(docRef.value)) return null;
    var data = docRef.value!.data() as Map<String, dynamic>;
    var entity = (data[listName] as List<dynamic>).firstWhere((task) {
      final dateTimeRange =
          _dateTimeRangeFromStrings(task["dateTimeEnd"], task[idName]);
      return dateTimeRange.start.isBefore(id) && dateTimeRange.end.isAfter(id);
    }, orElse: () => null);
    if (entity == null) return null;
    return fromJson(entity as Map<String, dynamic>);
  }

  DateTimeRange _dateTimeRangeFromStrings(String start, String end) {
    return DateTimeRange(
      start: DateTime.parse(start),
      end: DateTime.parse(end),
    );
  }

  void addHourlyListener({
    required String idc,
    required Function(PropertyHourWeather) listener,
  }) {
    eventsListener[idc] = listener;
    var now = DateTime.now();
    findById(id: now, idc: idc).then(
      (value) => listener(
        value ?? PropertyHourWeather.defaultConstructor(),
      ),
    );
  }

  void removeHourlyListener({required String idc}) {
    eventsListener.remove(idc);
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.minute == 0 && now.second == 0) {
        eventsListener.forEach((key, value) async {
          final weather = await findById(id: now, idc: key);
          value(weather ?? PropertyHourWeather.defaultConstructor());
        });
      }
    });
  }
}
