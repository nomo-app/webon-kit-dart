import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHexColor() {
    return '0x${value.toRadixString(16).padLeft(8, '0')}';
  }
}