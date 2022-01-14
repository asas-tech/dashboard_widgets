import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'breadcrumb_item.dart';

class BreadCrumb extends StatelessWidget {
  const BreadCrumb(
      {Key? key,
      this.breadcrumbs,
      this.breadcrumbDivider = '>',
      this.useRouterPath = false,
      this.icon})
      : super(key: key);

  final List<String>? breadcrumbs;
  final String breadcrumbDivider;
  final bool useRouterPath;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    List<String> breadcrumbPath =
        useRouterPath ? VRouter.of(context).path.split('/') : breadcrumbs ?? [];
    return Container(
        alignment: AlignmentDirectional.topStart,
        child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              icon ?? const SizedBox(),
              for (int i = 0; i < breadcrumbPath.length; i++)
                BreadcrumbItem(
                  label: breadcrumbPath[i],
                  isActive: breadcrumbPath.length - 1 == i,
                  breadcrumbDivider: breadcrumbDivider,
                ),
            ]));
  }
}
