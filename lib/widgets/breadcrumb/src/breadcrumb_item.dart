import 'package:flutter/material.dart';

class BreadcrumbItem extends StatelessWidget {
  const BreadcrumbItem(
      {Key? key,
      this.label,
      this.icon,
      this.onTap,
      this.isActive,
      this.customColor,
      this.breadcrumbDivider})
      : super(key: key);

  final String? label;
  final IconData? icon;
  final Function? onTap;
  final bool? isActive;
  final Color? customColor;
  final String? breadcrumbDivider;

  bool checkIsActive() {
    if (onTap != null) {
      return isActive ?? true;
    } else {
      return isActive ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    bool isActive = checkIsActive();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label != null
                ? '$label  ${isActive ? '' : breadcrumbDivider} '
                : '',
            style: TextStyle(
                color: isActive ? primary : Colors.grey,
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
          ),
      ],
    );
  }
}
