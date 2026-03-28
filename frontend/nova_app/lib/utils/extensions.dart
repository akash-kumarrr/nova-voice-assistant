import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth  => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool   get isMobile     => screenWidth < 600;
}

extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isBlank => trim().isEmpty;
}
