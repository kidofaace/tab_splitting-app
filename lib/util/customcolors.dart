import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String HexColor) {
    HexColor = HexColor.toUpperCase().replaceAll("#", "");
    if (HexColor.length == 6) {
      HexColor = "FF" + HexColor;
    }
    return int.parse(HexColor, radix: 16);
  }

  HexColor(final String HexColor) : super(_getColorFromHex(HexColor)){}
}