import 'package:calculator_app/custom/custom_appBar.dart';
import 'package:calculator_app/custom/custom_colors.dart';
import 'package:calculator_app/providers/theme_provider.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Error extends StatelessWidget {

  final String errorText;
  Error({this.errorText});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(isCalculator: false,)
      ),
      backgroundColor: themeProvider.isDarkTheme
      ? darkAppBackgroundBlack
      : lightAppBackgroundWhite,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/wireless-error.svg",
              color: themeProvider.isDarkTheme
              ? darkSecondaryGrey
              : lightSecondaryBlack,
              width: 75,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: themeProvider.isDarkTheme
                  ? Colors.red.shade600
                  : Colors.red.shade300,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}