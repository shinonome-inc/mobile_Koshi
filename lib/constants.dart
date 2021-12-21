import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Constants {
  String primary = "#000000";
  String grey = "#828282";
  String black = "#333333";
  String grey6 = "#F2F2F2";
  String darkGrey = "#B2B2B2";
  String white = "#FFFFFF";
}