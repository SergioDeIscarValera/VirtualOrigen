import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

class InversorChart extends StatelessWidget {
  const InversorChart({
    super.key,
    required this.batteryData,
    required this.gainData,
    required this.consumptionData,
    required this.dateData,
    required this.leftTitle,
    required this.bottomTitle,
    required this.displayCount,
    required this.offset,
  });

  final List<DateTime> dateData;
  final List<FlSpot> batteryData;
  final List<FlSpot> gainData;
  final List<FlSpot> consumptionData;
  final String leftTitle;
  final String bottomTitle;
  final int displayCount;
  final int offset;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd HH:mm');
    final batteryDisplay = _refortmatList(batteryData, offset, displayCount);
    final gainDisplay = _refortmatList(gainData, offset, displayCount);
    final consumptionDisplay =
        _refortmatList(consumptionData, offset, displayCount);
    final displayedDateData = dateData.sublist(offset - displayCount, offset);

    return LineChart(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 0),
      LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: displayCount.toDouble() - 1,
        lineBarsData: [
          LineChartBarData(
            spots: batteryDisplay,
            isCurved: true,
            color: MyColors.LIGHT.color,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: MyColors.LIGHT.color.withOpacity(0.3),
            ),
          ),
          LineChartBarData(
            spots: gainDisplay,
            isCurved: true,
            color: MyColors.SUCCESS.color,
            barWidth: 2,
            isStrokeCapRound: true,
          ),
          LineChartBarData(
            spots: consumptionDisplay,
            isCurved: true,
            color: MyColors.DANGER.color,
            barWidth: 2,
            isStrokeCapRound: true,
          ),
        ],
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (_) => const FlLine(
            color: Colors.white70,
            strokeWidth: 1,
            dashArray: [8, 4],
          ),
          getDrawingVerticalLine: (_) => const FlLine(
            color: Colors.white70,
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
                  case 4:
                    text = '${touchedSpot.y.toInt()} %';
                    break;
                  case 2:
                    text = '${(touchedSpot.y * 100).round()} W';
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
          leftTitles: AxisTitles(
            axisNameSize: 64,
            axisNameWidget: Text(
              leftTitle,
              style: MyTextStyles.h3.textStyle.copyWith(
                color: MyColors.LIGHT.color,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 34,
              getTitlesWidget: (number, titleMeta) {
                if (number == 0) {
                  return const SizedBox();
                }
                return Text(
                  '${number.toInt()} %',
                  style: MyTextStyles.p.textStyle.copyWith(
                    fontSize: 10,
                    color: MyColors.LIGHT.color,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            axisNameSize: 32,
            axisNameWidget: Text(
              bottomTitle,
              style: MyTextStyles.h3.textStyle.copyWith(
                color: MyColors.LIGHT.color,
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
                    color: MyColors.LIGHT.color,
                  ),
                );
              },
            ),
          ),
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
}
