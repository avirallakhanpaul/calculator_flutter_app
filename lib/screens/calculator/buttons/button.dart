import "package:flutter/material.dart";

class Button extends StatelessWidget {

  final Color btnColor;
  final String btnText;
  final double btnTextSize;
  final Color btnTextColor;
  final btnIcon;
  final bool isEqualButton;
  final Function isTapped;
  final Function isLongTapped;

  Button({
    this.btnColor = Colors.transparent,
    this.btnText,
    this.btnTextSize = 30.0,
    this.btnTextColor,
    this.btnIcon = "",
    this.isEqualButton = false,
    this.isTapped,
    this.isLongTapped,
  });

  @override
  Widget build(BuildContext context) {

  final textTheme = Theme.of(context).textTheme;

    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0.0),
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: isEqualButton
          ? BorderRadius.circular(10)
          : BorderRadius.circular(10),
        ),
      ),
      onPressed: isTapped,
      onLongPress: isLongTapped,
      child: Align(
        alignment: Alignment.center,
        child: btnIcon != ""
        ? btnIcon
        : Text(
          btnText,
          style: textTheme.bodyText1.copyWith(
            color: btnTextColor,
            fontSize: btnTextSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}