import "package:flutter/material.dart";

import '../../../custom/custom_colors.dart';

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
    this.btnTextSize = 32.0,
    this.btnTextColor = secondaryBlack,
    this.btnIcon = "",
    this.isEqualButton = false,
    this.isTapped,
    this.isLongTapped,
  });

  @override
  Widget build(BuildContext context) {

  final textTheme = Theme.of(context).textTheme;

    return FlatButton(
      onPressed: isTapped,
      onLongPress: isLongTapped,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: isEqualButton
        ? BorderRadius.circular(10)
        : BorderRadius.circular(100),
      ),
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