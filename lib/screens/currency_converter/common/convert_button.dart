import 'package:calculator_app/custom/custom_colors.dart';
import 'package:calculator_app/providers/currency_calculator_provider.dart';
import 'package:calculator_app/providers/theme_provider.dart';
import 'package:feature_discovery/feature_discovery.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ConvertButton extends StatefulWidget {
  @override
  _ConvertButtonState createState() => _ConvertButtonState();
}

class _ConvertButtonState extends State<ConvertButton> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(
        context, 
        [
          "swap-currencies",
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final currCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final double keyboard = MediaQuery.of(context).viewInsets.bottom;

    return DescribedFeatureOverlay(
      featureId: "swap-currencies",
      tapTarget: SvgPicture.asset(
        "assets/icons/arrow.svg",
        color: darkPrimaryBlue,
        fit: BoxFit.fill,
        width: 42,
      ),
      targetColor: Colors.white,
      title: Container(
        width: 250,
        child: Text(
          "Convert Button",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
      description: Container(
        width: 200,
        child: Text(
          "Long-Press to swap currencies",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      contentLocation: ContentLocation.trivial,
      // backgroundDismissible: false,
      backgroundColor: Colors.blue,
      barrierDismissible: false,
      overflowMode: OverflowMode.wrapBackground,
      child: ElevatedButton(
        onPressed: () {
          if(keyboard != 0) {
            FocusScope.of(context).unfocus();
          }
          currCalcProvider.calculateConversionValue();
        },
        onLongPress: () {
          currCalcProvider.switchCurrencyValues();
        },
        child: SvgPicture.asset(
          "assets/icons/arrow.svg",
          color: Colors.white,
          fit: BoxFit.fill,
          width: 42,
        ),
        style: ElevatedButton.styleFrom(
          primary: themeProvider.isDarkTheme
          ? darkPrimaryBlue
          : lightPrimaryBlue,
          elevation: 0.0,
          padding: EdgeInsets.all(40),
          shape: CircleBorder(
            side: BorderSide(
              width: 6,
              color: themeProvider.isDarkTheme
              ? darkAppBackgroundBlack
              : lightAppBackgroundWhite,
            ),
          ),
        ),
      ),
    );
  }
}