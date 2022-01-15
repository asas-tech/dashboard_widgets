import 'package:flutter/material.dart';

class ButtonGroup extends StatefulWidget {
  const ButtonGroup(
      {Key? key, required this.labels, required this.onSelectedItem})
      : super(key: key);

  final List<String> labels;
  final void Function(int) onSelectedItem;

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  int? selectedItem;
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: primary, width: 0.5),
          borderRadius: BorderRadius.circular(4)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        for (int i = 0; i < widget.labels.length; i++)
          InkWell(
            onTap: () {
              setState(() {
                widget.onSelectedItem(i);
                selectedItem = i;
              });
            },
            onHover: (value) {},
            splashColor: primary.withOpacity(0.2),
            hoverColor: Colors.transparent,
            focusColor: primary.withOpacity(0.2),
            highlightColor: primary.withOpacity(0.2),
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selectedItem == i
                      ? primary.withOpacity(0.2)
                      : Colors.transparent,
                  border: Border.all(color: primary, width: 0.5),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(i == 0 ? 4 : 0),
                      right: Radius.circular(
                          i == widget.labels.length - 1 ? 4 : 0)),
                ),
                child: Text(
                  widget.labels[i],
                  style: TextStyle(
                      color: selectedItem == i ? primary : Colors.black),
                )),
          ),
      ]),
    );
  }
}
