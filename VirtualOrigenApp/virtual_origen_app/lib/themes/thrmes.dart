import 'package:flutter/material.dart';
import 'package:virtual_origen_app/themes/colors.dart';
import 'package:virtual_origen_app/themes/styles/my_text_styles.dart';

enum Themes { LIGHT, DARK }

extension ThemesData on Themes {
  ThemeData get data {
    switch (this) {
      case Themes.LIGHT:
        return ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: MyColors.PRIMARY.color,
              onPrimary: MyColors.PRIMARY_EMPHSIS.color,
              secondary: MyColors.SECONDARY.color,
              onSecondary: MyColors.SECONDARY_EMPHSIS.color,
              error: MyColors.DANGER.color,
              onError: MyColors.DANGER_EMPHSIS.color,
              background: MyColors.LIGHT.color,
              onBackground: MyColors.LIGHT_EMPHSIS.color,
              surface: MyColors.LIGHT.color,
              onSurface: MyColors.LIGHT_EMPHSIS.color,
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(MyColors.DARK.color),
            ),
            sliderTheme: SliderThemeData(
              inactiveTrackColor: MyColors.DARK_EMPHSIS.color,
              valueIndicatorColor: MyColors.DARK.color,
              valueIndicatorTextStyle: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.LIGHT.color,
              ),
            ),
            fontFamily: "ValeraRound");
      case Themes.DARK:
        return ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: MyColors.PRIMARY.color,
              onPrimary: MyColors.PRIMARY_EMPHSIS.color,
              secondary: MyColors.SECONDARY.color,
              onSecondary: MyColors.SECONDARY_EMPHSIS.color,
              error: MyColors.DANGER.color,
              onError: MyColors.DANGER_EMPHSIS.color,
              background: MyColors.DARK.color,
              onBackground: MyColors.DARK_EMPHSIS.color,
              surface: MyColors.DARK.color,
              onSurface: MyColors.DARK_EMPHSIS.color,
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(MyColors.LIGHT.color),
            ),
            sliderTheme: SliderThemeData(
              inactiveTrackColor: MyColors.LIGHT_EMPHSIS.color,
              valueIndicatorColor: MyColors.LIGHT.color,
              valueIndicatorTextStyle: MyTextStyles.p.textStyle.copyWith(
                color: MyColors.DARK.color,
              ),
            ),
            //Date picker
            datePickerTheme: DatePickerThemeData(
              backgroundColor: MyColors.LIGHT.color,
            ),
            //Time picker
            timePickerTheme: TimePickerThemeData(
              backgroundColor: MyColors.LIGHT.color,
            ),
            fontFamily: "VarelaRound");
    }
  }
}
