import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFF91D893);
  static const Color backgroundColor = Color(0xFFCAF0CC);
  static const Color accentColor = Color(0xFF388E3C);
  static const Color textColor = Color.fromARGB(222, 0, 0, 0);
  static const Color buttonTextColor = Color.fromARGB(255, 255, 255, 255);
  static const Color darkAccentColor = Color(0xFF011202);
}

extension ColorChanger on Color {
  Color darken([double factor = 0.1]) {
    if (factor > 1 || factor < 0) return this;

    final double r = red * (1 - factor);
    final double g = green * (1 - factor);
    final double b = blue * (1 - factor);
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), opacity);
  }

  Color adjustSaturation([double saturationFactor = 0.1]) {
    if (saturationFactor > 1 || saturationFactor < 0) return this;

    HSLColor hslColor = HSLColor.fromColor(this);
    HSLColor adjustedColor = hslColor.withSaturation(saturationFactor);
    return adjustedColor.toColor();
  }

  Color textColorBasedOnBackground() {
    return this.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
