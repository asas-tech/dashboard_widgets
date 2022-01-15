import 'package:flutter/material.dart';
import '../../enums/shape.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar(
      {Key? key,
      this.backgroundColor,
      required this.name,
      this.customContent,
      this.image,
      this.isLight = false,
      this.shape = Shape.circle,
      this.size = 50,
      this.badgeAlignment = Alignment.bottomRight})
      : super(key: key);

  final Color? backgroundColor;
  final String name;
  final String? customContent;
  final ImageProvider? image;
  final bool isLight;
  final Shape shape;
  final Alignment badgeAlignment;
  final double? size;

  String getInitials(String? nameInitial) {
    if (name.isEmpty) {
      return "";
    }
    List<String> names = nameInitial?.split(" ") ?? [];
    String initials = "";
    if (names.length < 2) return names[0][0].toUpperCase();
    for (var i = 0; i < 2; i++) {
      initials += names[i][0].toUpperCase();
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    Color bColor = backgroundColor ?? Theme.of(context).primaryColor;
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      child: image == null
          ? Text(
              customContent ?? getInitials(name),
              style: TextStyle(
                  color: bColor.computeLuminance() > 0.5
                      ? Colors.black
                      : isLight
                          ? bColor
                          : Colors.white),
            )
          : null,
      decoration: BoxDecoration(
          shape: shape == Shape.circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              shape == Shape.rounded ? BorderRadius.circular(4) : null,
          color: isLight ? bColor.withOpacity(0.1) : bColor),
    );
  }
}
