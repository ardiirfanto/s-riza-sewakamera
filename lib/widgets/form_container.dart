import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormContainer extends StatelessWidget {
  final Widget child;
  const FormContainer({
    this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
