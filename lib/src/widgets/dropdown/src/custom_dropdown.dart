import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dropdown_button.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown(
      {Key? key, this.value, this.itemList, required this.onChanged})
      : super(key: key);
  final T? value;
  final List<T?>? itemList;
  final ValueChanged<T?>? onChanged;

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
    return DropdownButtonHideUnderline(
        child: DropdownButton<T?>(
      dropdownColor: const Color(0xFFffefd5),
      borderRadius: BorderRadius.circular(10.0),
      value: widget.value,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(
        color: Colors.black,
      ),
      onChanged: widget.onChanged,
      items: dropDownWidgetList,
    ));
  }
}
