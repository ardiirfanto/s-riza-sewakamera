import 'package:flutter/material.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';

// Class Widget Button
class Button extends StatelessWidget {
  final Color color;
  final Function onPress;
  final String text;
  final double rounded;
  final double textSize;

  Button({this.color, this.onPress, this.text, this.rounded, this.textSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
      ),
      child: Text(
        text,
        style: textStyle.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: textSize,
        ),
      ),
    );
  }
}

// Class Widget Border Button
class BorderButton extends StatelessWidget {
  final Color color;
  final Function onPress;
  final double rounded;
  final Color borderColor;
  final double borderWidth;
  final Widget child;

  BorderButton({
    this.color,
    this.onPress,
    this.child,
    this.rounded,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded),
          ),
          side: BorderSide(color: borderColor, width: borderWidth)),
      child: child,
    );
  }
}
