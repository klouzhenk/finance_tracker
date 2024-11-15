import 'package:flutter/material.dart';

extension ColorChanger on Color {
  Color darken([double factor = 0.1]) {
    if (factor > 1 || factor < 0) return this;

    final double r = this.red * (1 - factor);
    final double g = this.green * (1 - factor);
    final double b = this.blue * (1 - factor);
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), this.opacity);
  }

  Color adjustSaturation([double saturationFactor = 0.1]) {
    if (saturationFactor > 1 || saturationFactor < 0) return this;

    HSLColor hslColor = HSLColor.fromColor(this);
    HSLColor adjustedColor = hslColor.withSaturation(saturationFactor);
    return adjustedColor.toColor();
  }
}
