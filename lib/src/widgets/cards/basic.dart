import 'package:flutter/material.dart';

class BasicCard extends StatelessWidget {
  const BasicCard({Key? key, this.child}) : super(key: key);

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 5),
            BoxShadow(
                offset: Offset(0, -1), color: Colors.black12, blurRadius: 5)
          ]),
      child: child,
    );
  }
}
