import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class MyMultiTimePicker extends StatelessWidget {
  const MyMultiTimePicker({
    Key? key,
    required this.timeZones,
    required this.onChanged,
  }) : super(key: key);
  final List<DateTimeRange> timeZones;
  final Function(List<DateTimeRange>) onChanged;
  @override
  Widget build(BuildContext context) {
    RxList<DateTimeRange> timeZonesRx = timeZones.obs;
    return Column(
      children: [
        Text(
          "time_zones".tr,
          style: MyTextStyles.h3.textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              hoverColor: Colors.white.withOpacity(0.3),
              onPressed: () {
                if (timeZonesRx.isNotEmpty) {
                  timeZonesRx.removeLast();
                  onChanged(timeZonesRx);
                }
              },
              icon: Icon(
                Icons.remove,
                color: MyColors.DANGER.color,
              ),
            ),
            IconButton(
              hoverColor: Colors.white.withOpacity(0.3),
              onPressed: () async {
                var selectedTimeStart = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                var selectedTimeEnd = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (selectedTimeStart == null || selectedTimeEnd == null) {
                  return;
                }
                var startDateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectedTimeStart.hour,
                  selectedTimeStart.minute,
                );
                var endDateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  selectedTimeEnd.hour,
                  selectedTimeEnd.minute,
                );
                if (startDateTime.isAfter(endDateTime)) {
                  Get.snackbar(
                    "error".tr,
                    "start_time_cannot_be_after_end_time".tr,
                    backgroundColor: MyColors.WARNING.color.withOpacity(0.5),
                    colorText: MyColors.LIGHT.color,
                  );
                  return;
                }
                timeZonesRx.add(DateTimeRange(
                  start: startDateTime,
                  end: endDateTime,
                ));
                onChanged(timeZonesRx);
              },
              icon: Icon(
                Icons.add,
                color: MyColors.SUCCESS.color,
              ),
            ),
          ],
        ),
        Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: timeZonesRx
                  .map(
                    (e) => Wrap(
                      children: [
                        Text(
                          "${e.start.hour.toString().padLeft(2, "0")}:${e.start.minute.toString().padLeft(2, "0")} - ${e.end.hour.toString().padLeft(2, "0")}:${e.end.minute.toString().padLeft(2, "0")}",
                          style: MyTextStyles.p.textStyle,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${e.end.difference(e.start).inMinutes}  min",
                          style: MyTextStyles.p.textStyle,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            )),
      ],
    );
  }
}
