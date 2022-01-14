import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dropdown_button.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown(
      {Key? key, this.value, this.itemList, required this.onChanged})
      : super(key: key);
  final T? value;
  final List<T?>? itemList;
  final ValueChanged<T> onChanged;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  List<DropdownMenuItem<T>> dropDownWidgetList = [];

  @override
  initState() {
    super.initState();
    if (widget.itemList != null) {
      for (var i in widget.itemList!) {
        dropDownWidgetList.add(
          DropdownMenuItem(
            value: i,
            child: Text('${i}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownBelow(
      value: widget.value,
      icon: const Icon(CupertinoIcons.chevron_down),
      items: dropDownWidgetList,
      onChanged: widget.onChanged,
    );
  }
}
