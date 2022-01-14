import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData? icon;
  final Widget? child;
  final String routeName;

  final List<MenuItem>? menuItems;

  /// set true if you want the menu to be expanded from the beginning
  final bool isFirst;

  DrawerItem({
    required this.title,
    required this.routeName,
    this.icon,
    this.child,
    this.menuItems = const [],
    this.isFirst = false,
  });
}

class MenuItem {
  final String title;
  final String routeName;
  final Widget? child;
  final List<MenuItem>? menuItems;
  final IconData? icon;
  final List<MenuItem>? stackedRoutes;
  final String? label;
  final Color labelColor;

  MenuItem({
    required this.title,
    this.icon,
    required this.routeName,
    this.child,
    this.menuItems,
    this.stackedRoutes,
    this.label,
    this.labelColor = Colors.amberAccent,
  });
}
