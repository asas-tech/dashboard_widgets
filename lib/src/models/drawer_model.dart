import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData? icon;
  final Widget? child;
  final String routeName;

  final List<DrawerMenuItem>? menuItems;

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

class DrawerMenuItem {
  final String title;
  final String routeName;
  final Widget? child;
  final List<DrawerMenuItem>? menuItems;
  final IconData? icon;
  final List<DrawerMenuItem>? stackedRoutes;
  final String? label;
  final Color labelColor;

  DrawerMenuItem({
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
