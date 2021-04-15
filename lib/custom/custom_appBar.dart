import 'package:calculator_app/providers/theme_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:feature_discovery/feature_discovery.dart';

import 'custom_colors.dart';
import '../screens/currency_converter/currency_converter_screen.dart';
import '../screens/calculator/calculator_screen.dart';

class CustomAppBar extends StatefulWidget {

  final bool isCalculator;
  CustomAppBar({this.isCalculator}); 

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(
        context, 
        [
          "currency-converter-button",
          "theme-toggle-button",
        ],
      );
    });
  }

  @override
  AppBar build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      brightness: themeProvider.isDarkTheme
      ? Brightness.dark
      : Brightness.light,
      backgroundColor: themeProvider.isDarkTheme
      ? darkAppBackgroundBlack
      : lightAppBackgroundWhite,
      elevation: 0.0,
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: widget.isCalculator
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.calculate_rounded,
                            size: 32,
                            color: themeProvider.isDarkTheme
                            ? darkPrimaryBlue
                            : lightPrimaryBlue,
                          ),
                          splashRadius: 28,
                          onPressed: () {},
                        ),
                        Container(
                          width: 35,
                          height: 2,
                          color: themeProvider.isDarkTheme
                          ? darkPrimaryBlue
                          : lightPrimaryBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    DescribedFeatureOverlay(
                      featureId: "currency-converter-button",
                      // backgroundColor: themeProvider.isDarkTheme
                      // ? darkPrimaryBlue
                      // : lightPrimaryBlue,
                      backgroundColor: Colors.blue,
                      // backgroundDismissible: false,
                      barrierDismissible: false,
                      contentLocation: ContentLocation.below,
                      overflowMode: OverflowMode.wrapBackground,
                      title: Text(
                        "Currency Converter",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          letterSpacing: 0.6,
                        ),
                      ),
                      tapTarget: Icon(
                        Icons.attach_money,
                        size: 30,
                        color: lightPrimaryBlue,
                      ),
                      targetColor: themeProvider.isDarkTheme 
                      ? darkAppBackgroundBlack
                      : Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.attach_money,
                          size: 30,
                          color: themeProvider.isDarkTheme
                          ? darkSecondaryGrey
                          : lightSecondaryBlack,
                        ),
                        splashRadius: 28,
                        onPressed: () {
                          // Navigator.of(context).pushReplacementNamed(CurrencyConverterScreen.routeName);
                          Navigator.pushReplacement(
                            context, 
                            PageTransition(
                              child: FeatureDiscovery(
                                child: CurrencyConverterScreen()
                              ),
                              type: PageTransitionType.rightToLeftWithFade,
                              ctx: context,
                              duration: Duration(milliseconds: 300),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.calculate_outlined,
                        size: 35,
                        color: themeProvider.isDarkTheme
                        ? darkSecondaryGrey
                        : lightSecondaryBlack,
                      ),
                      splashRadius: 28,
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed(CalculatorScreen.routeName);
                        Navigator.pushReplacement(
                          context, 
                          PageTransition(
                            child: FeatureDiscovery(
                              child: CalculatorScreen(),
                            ),
                            type: PageTransitionType.leftToRightWithFade,
                            ctx: context,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.attach_money,
                            size: 30,
                            color: themeProvider.isDarkTheme
                            ? darkPrimaryBlue
                            : lightPrimaryBlue,
                          ),
                          splashRadius: 28,
                          onPressed: () {},
                        ),
                        Container(
                          width: 30,
                          height: 2,
                          color: themeProvider.isDarkTheme
                          ? darkPrimaryBlue
                          : lightPrimaryBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DescribedFeatureOverlay(
                featureId: "theme-toggle-button",
                // backgroundColor: themeProvider.isDarkTheme
                // ? darkPrimaryBlue
                // : lightPrimaryBlue,
                backgroundColor: Colors.blue,
                // backgroundDismissible: false,
                barrierDismissible: false,
                contentLocation: ContentLocation.below,
                overflowMode: OverflowMode.clipContent,
                title: Text(
                  "Theme Toggle",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    letterSpacing: 0.6,
                  ),
                ),
                description: Text(
                  "Light/Dark Mode",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    // fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.4,
                  ),
                ),
                tapTarget: themeProvider.isDarkTheme
                ? SvgPicture.asset(
                  "assets/icons/moon_fill.svg",
                  color: darkSecondaryGrey,
                  fit: BoxFit.cover,
                  width: 25
                )
                : SvgPicture.asset(
                  "assets/icons/moon_outline.svg",
                  color: lightSecondaryBlack,
                  fit: BoxFit.cover,
                  width: 25,
                ),
                targetColor: themeProvider.isDarkTheme 
                ? darkAppBackgroundBlack
                : Colors.white,
                child: IconButton(
                  icon: themeProvider.isDarkTheme
                  ? SvgPicture.asset(
                    "assets/icons/moon_fill.svg",
                    color: darkSecondaryGrey,
                    fit: BoxFit.cover,
                    width: 25
                  )
                  : SvgPicture.asset(
                    "assets/icons/moon_outline.svg",
                    color: lightSecondaryBlack,
                    fit: BoxFit.cover,
                    width: 25,
                  ),
                  splashRadius: 28,
                  onPressed: themeProvider.toggleTheme,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}