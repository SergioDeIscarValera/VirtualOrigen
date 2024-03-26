import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:virtual_origen_app/models/inversor_now.dart';
import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class PropertyLongCard extends StatelessWidget {
  const PropertyLongCard({
    Key? key,
    required this.property,
    required this.inversorNow,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  final Property property;
  final Future<InversorNow> inversorNow;
  final Function(Property) onTap;
  final Function(Property) onLongPress;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(property),
        onLongPress: () => onLongPress(property),
        child: Container(
          decoration: BoxDecoration(
            color: property.color.color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    property.name,
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: MyColors.LIGHT.color,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FutureBuilder(
                    future: inversorNow,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: snapshot.data!.battery / 100,
                                borderRadius: BorderRadius.circular(12),
                                minHeight: 20,
                                backgroundColor: MyColors.LIGHT.color,
                                valueColor: AlwaysStoppedAnimation(
                                  snapshot.data!.battery < 15
                                      ? MyColors.DANGER.color
                                      : snapshot.data!.battery < 40
                                          ? MyColors.WARNING.color
                                          : MyColors.SUCCESS.color,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${snapshot.data!.battery.toInt()} %",
                              style: MyTextStyles.p.textStyle.copyWith(
                                color: MyColors.LIGHT.color,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Info tocha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.LIGHT.color,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "images/weathers/sunny.png",
                      width: 100,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.device_thermostat,
                            color: MyColors.LIGHT.color,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "0 º",
                            style: MyTextStyles.p.textStyle.copyWith(
                              color: MyColors.LIGHT.color,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: MyColors.LIGHT.color,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "0 %",
                            style: MyTextStyles.p.textStyle.copyWith(
                              color: MyColors.LIGHT.color,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.battery_saver,
                            color: MyColors.LIGHT.color,
                          ),
                          const SizedBox(width: 10),
                          FutureBuilder(
                            future: inversorNow,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                "${snapshot.data!.gain.toInt()} W",
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                  fontSize: 22,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.battery_charging_full,
                            color: MyColors.LIGHT.color,
                          ),
                          const SizedBox(width: 10),
                          FutureBuilder(
                            future: inversorNow,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                "${snapshot.data!.battery.toInt()} W",
                                style: MyTextStyles.p.textStyle.copyWith(
                                  color: MyColors.LIGHT.color,
                                  fontSize: 22,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 175,
                    width: 450,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              property.location.key, property.location.value),
                          zoom: 12,
                        ),
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        markers: {
                          Marker(
                            markerId: const MarkerId('m1'),
                            position: LatLng(
                                property.location.key, property.location.value),
                            draggable: false,
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Otra información
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "devices".tr.replaceAll("{devices}", "0"),
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: MyColors.LIGHT.color,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "guests".tr.replaceAll(
                        "{guests}", property.guests.length.toString()),
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: MyColors.LIGHT.color,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
