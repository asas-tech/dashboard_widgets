import 'package:dashboard_widgets/dashboard_widgets.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key? key,
      required this.child,
      required this.drawerItems,
      this.backgroundColor,
      this.appbarColor,
      this.isRtl = false,
      this.appName,
      this.logo,
      this.showUser = true,
      this.showNotification = true,
      this.showUserData = true,
      this.userIcon,
      this.userName,
      this.userRole,
      this.isFloating = false,
      this.isDark = true,
      this.appBarRadius,
      this.horizontalPadding = 24})
      : super(key: key);

  final Widget child;
  final List<DrawerItem> drawerItems;
  final Color? backgroundColor, appbarColor;
  final bool isRtl;
  final String? appName;
  final Widget? logo;
  final bool showUser, showUserData, showNotification;
  final Widget? userIcon;
  final String? userName;
  final String? userRole;
  final bool isFloating;
  final bool isDark;
  final double? appBarRadius;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
        drawer: Responsive.isMobile(context)
            ? SideBar(
                drawerList: drawerItems,
                isCollapsed: false,
                appName: appName,
                logo: logo,
                isRtl: isRtl,
              )
            : null,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: isFloating ? horizontalPadding : 0.0,
                vertical: isFloating ? 8 : 0.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    isFloating || appBarRadius != null
                        ? appBarRadius ?? 12.0
                        : 0.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        isFloating || appBarRadius != null
                            ? appBarRadius ?? 12.0
                            : 0.0,
                      ),
                    ),
                    elevation: 1.0,
                    shadowColor: Colors.grey.shade100,
                    centerTitle: true,
                    toolbarHeight: 80,
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showNotification)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.notifications,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  )),
                            ),
                          if (showUser)
                            Row(
                              children: [
                                if (showUserData)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        userName ?? '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87),
                                      ),
                                      Text(
                                        userRole ?? '',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w100,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black87),
                                      ),
                                    ],
                                  ),
                                horizontalSpaceSmall,
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: userIcon ??
                                      InkWell(
                                        onTap: () {},
                                        child: const CustomAvatar(
                                          backgroundColor: Colors.white,
                                          name: 'User',
                                        ),
                                      ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    backgroundColor:
                        appbarColor ?? Theme.of(context).primaryColor),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
