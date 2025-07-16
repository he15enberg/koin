import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TSwitchTheme {
  TSwitchTheme._();

  static SwitchThemeData lightSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected) ? TColors.white : TColors.grey),
    trackColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? TColors.primary
            : TColors.light),
    trackOutlineColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? TColors.primary
            : TColors.grey),
  );

  static SwitchThemeData darkSwitchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected) ? TColors.white : TColors.grey),
    trackColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? TColors.primary
            : TColors.dark),
    trackOutlineColor: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? TColors.primary
            : TColors.grey),
  );
}
