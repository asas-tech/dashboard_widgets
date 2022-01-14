import 'package:flutter/material.dart';
import '/shared/ui_helpers.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.width, this.color}) : super(key: key);
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: width ?? screenWidth(context),
      child: Center(
          child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor),
      )),
    );
  }
}
