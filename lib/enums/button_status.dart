import 'package:flutter/material.dart';

enum ButtonStatus { primary, secondary, success, danger, warning, info, dark }

extension ButtonStatusExtention on ButtonStatus {
  Color? valuOf(context) {
    switch (this) {
      case ButtonStatus.primary:
        return Theme.of(context).primaryColor;
      case ButtonStatus.secondary:
        return Theme.of(context).accentColor;
      case ButtonStatus.success:
        return Color(0xff28c76f);
      case ButtonStatus.danger:
        return Color(0xffea5455);
      case ButtonStatus.warning:
        return Color(0xffff9f43);
      case ButtonStatus.info:
        return Color(0xff00cfe8);
      case ButtonStatus.dark:
        return Color(0xff4b4b4b);
      default:
        return Theme.of(context).primaryColor;
    }
  }
}
