import 'package:flutter/material.dart';

enum ColorStatus { primary, secondary, success, danger, warning, info, dark }

extension ColorStatusExtention on ColorStatus {
  Color? valuOf(context) {
    switch (this) {
      case ColorStatus.primary:
        return Theme.of(context).primaryColor;

      case ColorStatus.secondary:
        return Theme.of(context).accentColor;
      case ColorStatus.success:
        return Color(0xff28c76f);

      case ColorStatus.danger:
        return Color(0xffea5455);

      case ColorStatus.warning:
        return Color(0xffff9f43);

      case ColorStatus.info:
        return Color(0xff00cfe8);

      case ColorStatus.dark:
        return Color(0xff4b4b4b);

      default:
        return Theme.of(context).primaryColor;
    }
  }
}
