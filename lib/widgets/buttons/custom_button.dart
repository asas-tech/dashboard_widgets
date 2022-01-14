import 'package:flutter/material.dart';
import '../../../enums/button_type.dart';
import '../../enums/status.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    this.label,
    this.colorStatus,
    this.buttonType = ButtonType.filled,
    this.fitWidth = false,
    this.icon,
    this.isRound = false,
    this.isLeadingIcon = true,
  }) : super(key: key);

  final String? label;
  final IconData? icon;
  final bool isLeadingIcon;
  final Function onTap;
  final ColorStatus? colorStatus;
  final ButtonType buttonType;
  final bool fitWidth;
  final bool isRound;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovering = false;

  BoxDecoration getBoxDecoration(Color buttonColor, BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.filled:
        return BoxDecoration(color: buttonColor, boxShadow: [
          isHovering
              ? BoxShadow(
                  color: buttonColor, offset: Offset(0, 2), blurRadius: 10)
              : BoxShadow()
        ]);
      case ButtonType.border:
        return BoxDecoration(
            color:
                isHovering ? buttonColor.withOpacity(0.01) : Colors.transparent,
            border: Border.all(color: buttonColor));

      case ButtonType.flat:
        return BoxDecoration(
          color: isHovering ? buttonColor.withOpacity(0.2) : Colors.transparent,
        );
      case ButtonType.gradient:
        return BoxDecoration(
          gradient: LinearGradient(colors: [
            buttonColor,
            buttonColor.withOpacity(0.7),
          ]),
          border: Border.all(color: buttonColor, width: 0.5),
        );

      case ButtonType.relief:
        return BoxDecoration(
          color: buttonColor,
        );
    }
  }

  Color getLabelColor(Color buttonColor, BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.filled:
      case ButtonType.gradient:
      case ButtonType.relief:
        return Colors.white;
      case ButtonType.border:
      case ButtonType.flat:
        return buttonColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        widget.colorStatus?.valuOf(context) ?? Theme.of(context).primaryColor;

    return InkWell(
      onTap: () => widget.onTap(),
      borderRadius: BorderRadius.circular(widget.isRound ? 56 : 4),
      hoverColor: buttonColor.withOpacity(0.1),
      splashColor: buttonColor.withOpacity(0.2),
      focusColor: buttonColor.withOpacity(0.2),
      highlightColor: buttonColor.withOpacity(0.2),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 8, horizontal: widget.label == null ? 8 : 20),
        decoration: getBoxDecoration(buttonColor, context).copyWith(
            borderRadius: BorderRadius.circular(widget.isRound ? 56 : 4)),
        child: Row(
          mainAxisSize: widget.fitWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null && widget.isLeadingIcon)
              Icon(
                widget.icon,
                size: 18,
                color: getLabelColor(
                  buttonColor,
                  context,
                ),
              ),
            if (widget.label != null) SizedBox(width: 4),
            Text(
              widget.label ?? '',
              style: TextStyle(color: getLabelColor(buttonColor, context)),
            ),
            if (widget.icon != null && !widget.isLeadingIcon)
              Icon(
                widget.icon,
                size: 18,
                color: getLabelColor(
                  buttonColor,
                  context,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
