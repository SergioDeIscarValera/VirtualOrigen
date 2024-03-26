import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:virtual_origen_app/models/pair.dart';
import 'package:virtual_origen_app/models/smart_device_type.dart';
import 'package:virtual_origen_app/themes/colors.dart';

class SmartDevice {
  final String id;
  final String name;
  final SmartDeviceType type;
  final MyColors color;
  final List<DateTimeRange> timeZones;
  final List<bool> days;
  final Pair<int, int>? batteryRange;
  final Pair<int, int>? productionRange;
  final Pair<int, int>? consumptionRange;
  final Pair<int, int>? temperatureRange;
  final Pair<int, int>? rainRange;
  final bool isManualMode;
  final bool isOn;

  SmartDevice({
    String? id,
    required this.name,
    required this.type,
    required this.color,
    required this.timeZones,
    required this.days,
    this.batteryRange,
    this.productionRange,
    this.consumptionRange,
    this.temperatureRange,
    this.rainRange,
    this.isManualMode = false,
    this.isOn = false,
  }) : id = id ?? const Uuid().v4();

  copyWith(
      {String? name,
      SmartDeviceType? type,
      MyColors? color,
      List<DateTimeRange>? timeZones,
      List<bool>? days,
      Pair<int, int>? batteryRange,
      Pair<int, int>? productionRange,
      Pair<int, int>? consumptionRange,
      Pair<int, int>? temperatureRange,
      Pair<int, int>? rainRange,
      bool? isManualMode,
      bool? isOn}) {
    return SmartDevice(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      color: color ?? this.color,
      timeZones: timeZones ?? this.timeZones,
      days: days ?? this.days,
      batteryRange: batteryRange ?? this.batteryRange,
      productionRange: productionRange ?? this.productionRange,
      consumptionRange: consumptionRange ?? this.consumptionRange,
      temperatureRange: temperatureRange ?? this.temperatureRange,
      rainRange: rainRange ?? this.rainRange,
      isManualMode: isManualMode ?? this.isManualMode,
      isOn: isOn ?? this.isOn,
    );
  }
}
