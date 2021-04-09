import 'package:feature_discovery/feature_discovery.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../../providers/theme_provider.dart';
import '../currency_converter/currency_converter_screen.dart';
import '../../custom/custom_colors.dart';
import 'buttons/buttons_grid.dart';
import 'result_window/result.dart';

class CalculatorScreen extends StatefulWidget {

  static const routeName = "/calculator";

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

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
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (ctx, theme, child) {
        return Scaffold(
          appBar: AppBar(
            brightness: theme.isDarkTheme 
            ? Brightness.dark
            : Brightness.light,
            backgroundColor: theme.isDarkTheme 
            ? darkAppBackgroundBlack
            : lightAppBackgroundWhite,
            elevation: 0.0,
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.calculate_rounded,
                                  size: 32,
                                  color: theme.isDarkTheme
                                  ? darkPrimaryBlue
                                  : lightPrimaryBlue,
                                ),
                                splashRadius: 28,
                                onPressed: () {},
                              ),
                              Container(
                                width: 35,
                                height: 2,
                                color: theme.isDarkTheme
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
                            // backgroundColor: theme.isDarkTheme
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
                            targetColor: theme.isDarkTheme 
                            ? darkAppBackgroundBlack
                            : Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.attach_money,
                                size: 30,
                                color: theme.isDarkTheme
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
                      ),
                    ),
                    DescribedFeatureOverlay(
                      featureId: "theme-toggle-button",
                      // backgroundColor: theme.isDarkTheme
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
                      tapTarget: theme.isDarkTheme
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
                      targetColor: theme.isDarkTheme 
                      ? darkAppBackgroundBlack
                      : Colors.white,
                      child: IconButton(
                        icon: theme.isDarkTheme
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
                        onPressed: theme.toggleTheme,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: theme.isDarkTheme
          ? darkOverallBackgroundBlue
          : lightOverallBackgroundBlue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.isDarkTheme
                    ? darkAppBackgroundBlack
                    : lightAppBackgroundWhite,
                    borderRadius: BorderRadius.only(
                      // bottomLeft: Radius.circular(25),
                      // bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Result(),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.isDarkTheme
                  ? darkAppBackgroundBlack
                  : lightAppBackgroundWhite,
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(25),
                    // topRight: Radius.circular(25),
                  ),
                ),
                child: ButtonsGrid(),
              ),
            ],
          ),
        );
      }
    );
  }
}