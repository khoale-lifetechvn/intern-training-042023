import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#ED9728");

  static Color greyBG = HexColor.fromHex("##86948F");
  static Color greyForm = HexColor.fromHex("#ABBFB8");
  static Color greyTF = HexColor.fromHex("#D9D9D9");
  static Color green = HexColor.fromHex("#B8E893");
  static Color black = HexColor.fromHex("#000000");

  static Color white = HexColor.fromHex("#FFFFFF");
  static Color red = Colors.red;
  static Color yellow = Colors.yellow;
  static Color blue = Colors.blue;
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
