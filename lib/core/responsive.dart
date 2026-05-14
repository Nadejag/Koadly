import 'dart:math' as math;

import 'package:flutter/material.dart';

class KoadlyResponsive {
  const KoadlyResponsive._(this.size, this.textScaleFactor);

  final Size size;
  final double textScaleFactor;

  static KoadlyResponsive of(BuildContext context) {
    final media = MediaQuery.of(context);
    return KoadlyResponsive._(media.size, media.textScaler.scale(1));
  }

  bool get isCompact => size.shortestSide < 390;
  bool get isTablet => size.shortestSide >= 600;

  double get scale {
    final base = size.shortestSide / 390;
    return base.clamp(0.88, isTablet ? 1.24 : 1.08).toDouble();
  }

  double get horizontalPadding => isTablet ? 32 : (isCompact ? 16 : 20);
  double get bottomPadding => isTablet ? 128 : 110;

  double gap(double value) => (value * scale).roundToDouble();

  double font(double value, {double? min, double? max}) {
    final scaled = value * scale;
    final low = min ?? value * 0.9;
    final high = max ?? value * (isTablet ? 1.18 : 1.08);
    return scaled.clamp(low, high).toDouble();
  }

  double icon(double value) {
    return math.max(16, value * scale).clamp(16, isTablet ? 36 : 30).toDouble();
  }

  double radius(double value) =>
      (value * scale).clamp(10, value + 6).toDouble();
}

extension KoadlyResponsiveX on BuildContext {
  KoadlyResponsive get responsive => KoadlyResponsive.of(this);
}
