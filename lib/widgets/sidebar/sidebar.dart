import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import '../../models/drawer_model.dart';
import '../../../shared/ui_helpers.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
    required this.drawerList,
    this.isCollapsed = true,
    this.drawerWidth = 260,
    this.collapsedDrawerWidth = 70,
    this.appName,
    this.logo,
    this.isRtl = false,
  }) : super(key: key);

  ///drawer list items
  final List<DrawerItem> drawerList;

  ///set true if you want the drawer to be collapsed (only show icons)
  final bool isCollapsed;

  ///width of drawer
  final double drawerWidth;

  ///width of collapsed drawer
  final double collapsedDrawerWidth;

  ///name shown on top of sidebar
  final String? appName;

  ///logo shown on top of sidebar perfered ratio 1:!
  final Widget? logo;

  ///true if sidebar items are rtl
  final bool isRtl;

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late bool _isCollapsed;
  late bool _isForcedUnCollapsed;
  int indexCount = 0;

  @override
  void initState() {
    super.initState();
    _isCollapsed = widget.isCollapsed;
    _isForcedUnCollapsed = !widget.isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                if (!_isForcedUnCollapsed) _isCollapsed = !value;
              });
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _isForcedUnCollapsed
                    ? widget.drawerWidth
                    : _isCollapsed
                        ? widget.collapsedDrawerWidth
                        : widget.drawerWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: ListView(children: [
                  SizedBox(
                      height: 65,
                      child: Center(
                        child: AnimatedCrossFade(
                            firstChild: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: widget.isRtl == true
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  SizedBox(
                                      height: 24,
                                      width: 24,
                                      child:
                                          widget.logo ?? const FlutterLogo()),
                                  horizontalSpaceSmall,
                                  Text(
                                    widget.appName ?? '',
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  if (!_isCollapsed)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isForcedUnCollapsed =
                                              !_isForcedUnCollapsed;
                                          _isCollapsed = !_isForcedUnCollapsed;
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.white70)),
                                        child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 10),
                                            width:
                                                _isForcedUnCollapsed ? 20 : 0,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _isForcedUnCollapsed
                                                    ? Colors.white70
                                                    : Colors.transparent)),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            secondChild: SizedBox(
                                height: 28,
                                width: 28,
                                child: widget.logo ?? const FlutterLogo()),
                            crossFadeState:
                                _isCollapsed && !_isForcedUnCollapsed
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            secondCurve: Curves.fastLinearToSlowEaseIn,
                            reverseDuration: const Duration(milliseconds: 150),
                            duration: const Duration(milliseconds: 150)),
                      )),
                  for (DrawerItem item in widget.drawerList)
                    _BuildHeader(
                      item: item,
                      menuItems: item.menuItems,
                      isCollapsed: _isCollapsed,
                      isForcedUnCollapsed: _isForcedUnCollapsed,
                      isFirst: item.isFirst,
                      isRtl: widget.isRtl,
                    )
                ]))));
  }
}

class _BuildHeader extends StatefulWidget {
  const _BuildHeader(
      {Key? key,
      required this.item,
      required this.menuItems,
      required this.isCollapsed,
      required this.isForcedUnCollapsed,
      this.isFirst = false,
      required this.isRtl})
      : super(key: key);
  final DrawerItem item;
  final List<MenuItem>? menuItems;
  final bool isCollapsed, isForcedUnCollapsed;
  final bool isFirst, isRtl;

  @override
  State<_BuildHeader> createState() => _BuildHeaderState();
}

class _BuildHeaderState extends State<_BuildHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _isExpanded = widget.isFirst;
    _isExpanded ? _controller.forward() : _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.menuItems != null &&
                  (widget.menuItems?.isNotEmpty ?? false)) {
                _isExpanded = !_isExpanded;
                _isExpanded ? _controller.forward() : _controller.reverse();
                setState(() {});
              } else {
                setState(() {
                  context.vRouter.to(widget.item.routeName);
                });
              }
            },
            hoverColor: Colors.black26.withOpacity(0.5),
            child: AnimatedCrossFade(
              firstChild: Container(
                  height: 65,
                  color: context.vRouter.path.split('/')[1] ==
                          widget.item.routeName.substring(1)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                  alignment: AlignmentDirectional.center,
                  child: Icon(
                    widget.item.icon ?? CupertinoIcons.ellipsis,
                    color: Colors.white60,
                  )),
              secondChild: Container(
                height: 65,
                color: context.vRouter.path.split('/')[1] ==
                        widget.item.routeName.substring(1)
                    ? Colors.white.withOpacity(0.1)
                    : Colors.transparent,
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  textDirection: widget.isRtl == true
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.item.icon ?? CupertinoIcons.ellipsis,
                      color: Colors.white60,
                    ),
                    horizontalSpaceSmall,
                    Text(widget.item.title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 16)),
                    const Spacer(),
                    if (widget.menuItems != null &&
                        (widget.menuItems?.isNotEmpty ?? false))
                      RotationTransition(
                        turns:
                            Tween(begin: 0.0, end: widget.isRtl ? -0.25 : 0.25)
                                .animate(_controller),
                        child: Icon(
                          widget.isRtl
                              ? CupertinoIcons.chevron_back
                              : CupertinoIcons.chevron_forward,
                          color: Colors.white60,
                        ),
                      )
                  ],
                ),
              ),
              crossFadeState: widget.isCollapsed && !widget.isForcedUnCollapsed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              reverseDuration: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 100),
            ),
          ),
          AnimatedCrossFade(
              firstChild: widget.menuItems != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.menuItems!.length,
                      itemBuilder: (context, index) => _BuildTile(
                            mainRoute: widget.item.routeName,
                            item: widget.menuItems![index],
                            isCollapsed: widget.isCollapsed,
                            isForcedUnCollapsed: widget.isForcedUnCollapsed,
                            isRtl: widget.isRtl,
                          ))
                  : const SizedBox(),
              secondChild: const SizedBox(),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 100))
        ],
      ),
    );
  }
}

class _BuildTile extends StatefulWidget {
  const _BuildTile(
      {Key? key,
      required this.item,
      required this.isCollapsed,
      required this.isForcedUnCollapsed,
      this.mainRoute,
      required this.isRtl})
      : super(key: key);

  final MenuItem item;
  final String? mainRoute;

  final bool isCollapsed, isForcedUnCollapsed, isRtl;
  @override
  State<_BuildTile> createState() => _BuildTileState();
}

class _BuildTileState extends State<_BuildTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          context.vRouter.to('${widget.mainRoute}${widget.item.routeName}');
        });
      },
      hoverColor: Colors.black26.withOpacity(0.5),
      child: AnimatedCrossFade(
        firstChild: Container(
            height: 65,
            color: context.vRouter.path.split('/')[1] ==
                    widget.item.routeName.substring(1)
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
            alignment: AlignmentDirectional.center,
            child: Icon(
              widget.item.icon ?? CupertinoIcons.circle,
              color: Colors.white60,
              size: 16,
            )),
        secondChild: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: context.vRouter.path.split('/').last.trim() ==
                  widget.item.routeName.substring(1)
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          child: Row(
            textDirection:
                widget.isRtl == true ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(
                widget.item.icon ?? CupertinoIcons.circle,
                size: 16,
                color: Colors.white,
              ),
              horizontalSpaceSmall,
              Text(
                widget.item.title,
                style: const TextStyle(color: Colors.white),
              ),
              horizontalSpaceSmall,
              if (widget.item.label != null)
                Text(
                  widget.item.label ?? '',
                  style: TextStyle(color: widget.item.labelColor, fontSize: 12),
                ),
            ],
          ),
        ),
        crossFadeState: widget.isCollapsed && !widget.isForcedUnCollapsed
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        reverseDuration: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 100),
      ),
    );
  }
}
