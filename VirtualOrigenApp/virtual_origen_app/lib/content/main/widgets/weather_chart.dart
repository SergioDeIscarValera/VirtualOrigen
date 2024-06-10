import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class WeatherChart extends StatelessWidget {
  const WeatherChart({
    Key? key,
    required this.temData,
    required this.rainData,
    required this.windSpeedData,
    required this.dateData,
    required this.bottomTitle,
    required this.displayCount,
    required this.offset,
  }) : super(key: key);
  final List<FlSpot> temData;
  final List<FlSpot> rainData;
  final List<FlSpot> windSpeedData;
  final List<DateTime> dateData;
  final String bottomTitle;
  final int displayCount;
  final int offset;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd HH:mm');
    final temDisplay = _refortmatList(temData, offset, displayCount);
    final rainDisplay = _refortmatList(rainData, offset, displayCount);
    final windSpeedDisplay =
        _refortmatList(windSpeedData, offset, displayCount);
    final displayedDateData = dateData.sublist(offset - displayCount, offset);
    final now = DateTime.now();
    return LineChart(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 0),
      LineChartData(
        minY: -20,
        maxY: 100,
        minX: 0,
        maxX: displayCount.toDouble() - 1,
        lineBarsData: [
          LineChartBarData(
            spots: temDisplay,
            isCurved: true,
            color: MyColors.ORANGE.color,
            barWidth: 4.01,
            isStrokeCapRound: true,
          ),
          LineChartBarData(
            spots: rainDisplay,
            isCurved: true,
            color: MyColors.INFO.color,
            barWidth: 4.02,
            isStrokeCapRound: true,
          ),
          LineChartBarData(
            spots: windSpeedDisplay,
            isCurved: true,
            color: MyColors.SUCCESS.color,
            barWidth: 4.03,
            isStrokeCapRound: true,
          ),
        ],
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (_) => FlLine(
            color: Get.isDarkMode ? Colors.white70 : Colors.black26,
            strokeWidth: 1,
            dashArray: [8, 4],
          ),
          getDrawingVerticalLine: (_) => FlLine(
            color: Get.isDarkMode ? Colors.white70 : Colors.black26,
            strokeWidth: 1,
            dashArray: [8, 4],
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: MyColors.DARK.color.withOpacity(0.6),
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(8),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                String text = '';
                switch (touchedSpot.bar.barWidth) {
                  case 4.01:
                    text = '${touchedSpot.y.round()} °C';
                    break;
                  case 4.02:
                    text = '${touchedSpot.y.round()} %';
                    break;
                  case 4.03:
                    text = '${touchedSpot.y.round()} m/s';
                    break;
                }
                return LineTooltipItem(
                  text,
                  MyTextStyles.p.textStyle.copyWith(
                    color: touchedSpot.bar.color,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameSize: 32,
            axisNameWidget: Text(
              bottomTitle,
              style: MyTextStyles.h3.textStyle.copyWith(
                color: MyColors.CONTRARY.color,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (number, titleMeta) {
                return Text(
                  formatter.format(
                    displayedDateData.elementAt(number.toInt()),
                  ),
                  style: MyTextStyles.p.textStyle.copyWith(
                    fontSize: 12,
                    color: MyColors.CONTRARY.color,
                  ),
                );
              },
            ),
          ),
        ),
        extraLinesData: ExtraLinesData(
          extraLinesOnTop: false,
          verticalLines: [
            VerticalLine(
              x: _nearestIndex(displayedDateData, now).toDouble(),
              color: MyColors.CONTRARY.color.withOpacity(0.8),
              strokeWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _refortmatList(List<FlSpot> data, int offset, int displayCount) {
    var count = -1;
    return data.sublist(offset - displayCount, offset).map((e) {
      count++;
      return FlSpot(count.toDouble(), e.y);
    }).toList();
  }

  int _nearestIndex(List<DateTime> lista, DateTime horaActual) {
    int indice = -1;
    Duration? diferenciaMinima;

    for (int i = 0; i < lista.length; i++) {
      Duration diferencia = horaActual.difference(lista[i]).abs();

      if (diferenciaMinima == null || diferencia < diferenciaMinima) {
        diferenciaMinima = diferencia;
        indice = i;
      }
    }

    return indice;
  }
}
