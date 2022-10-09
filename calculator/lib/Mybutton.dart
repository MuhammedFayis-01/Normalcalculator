import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback ontap;

  const MyButton(
      {super.key,
      required this.color,
      required this.text,
      required this.textColor,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          color: color,
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: textColor,fontSize: 20,),
          )),
        ),
      ),
    );
  }
}
