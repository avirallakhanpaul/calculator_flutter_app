import 'package:calculator_app/helpers/networkException.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "package:page_transition/page_transition.dart";
import "package:feature_discovery/feature_discovery.dart";

import '../../providers/currency_calculator_provider.dart';
import '../../providers/country_list_provider.dart';
import '../../providers/theme_provider.dart';
import 'common/currency_input.dart';
import '../calculator/calculator_screen.dart';
import '../../custom/custom_colors.dart';

class CurrencyConverterScreen extends StatefulWidget {

  static const routeName = "/currency";

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {

  var isError = false;
  String errorText;

  @override
  void initState() {
    super.initState();
    checkConnection();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(
        context, 
        [
          "swap-currencies",
        ],
      );
    });
  }

  void checkConnection() async {
    try {
      var connectionResult = await (Connectivity().checkConnectivity());
      if(connectionResult == ConnectivityResult.none) {
        // print("No internet found");
        throw NetworkException(errorText: "No internet found, please try again later");
      } else {
        CountryListProvider();
      }
    } catch(e) {
      print("Exception: ${e.errorText}");
      
      setState(() {
        isError = true;
        errorText = e.errorText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final Size mediaQuerySize = MediaQuery.of(context).size;
    final double keyboard = MediaQuery.of(context).viewInsets.bottom;
    final currCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    bool isDesiredCurrency = true;
    Color containerColor;
    
    AppBar appBar = AppBar(
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
                child: Row(
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
              IconButton(
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
            ],
          ),
        ),
      ],
    );

    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;

    return Consumer<ThemeProvider>(
      builder: (ctx, theme, _) {
        if(isDesiredCurrency && theme.isDarkTheme) {
          containerColor = darkPrimaryBlue;
        } else if(!isDesiredCurrency && theme.isDarkTheme) {
          containerColor = darkAppBackgroundBlack;
        } else if(isDesiredCurrency && !theme.isDarkTheme) {
          containerColor = lightPrimaryBlue;
        } else if(!isDesiredCurrency && !theme.isDarkTheme) {
          containerColor = lightAppBackgroundWhite;
        }

        return isError
        ? Scaffold(
          appBar: appBar,
          backgroundColor: theme.isDarkTheme
          ? darkAppBackgroundBlack
          : lightAppBackgroundWhite,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/wireless-error.svg",
                  color: theme.isDarkTheme
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
                      color: theme.isDarkTheme
                      ? Colors.red.shade600
                      : Colors.red.shade300,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        : WillPopScope(
          onWillPop: () async {
            currCalcProvider.clearValues();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            backgroundColor: theme.isDarkTheme
            ? darkOverallBackgroundBlue
            : lightOverallBackgroundBlue,
            body: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        // height: mediaQuerySize.height * 0.4,
                        decoration: BoxDecoration(
                          color: theme.isDarkTheme
                          ? darkAppBackgroundBlack
                          : lightAppBackgroundWhite,
                          borderRadius: BorderRadius.only(
                            // bottomLeft: Radius.circular(25),
                            // bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: CurrencyInput(
                          isDesiredCurr: false,
                          isFromCountry: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(25),
                            // topRight: Radius.circular(25),
                          ),
                        ),
                        child: CurrencyInput(
                          isDesiredCurr: true,
                          isFromCountry: false,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: (mediaQuerySize.width / 2) - 62,
                  top: (mediaQuerySize.height / 2) - statusBarHeight - appBarHeight - 21,
                  child: DescribedFeatureOverlay(
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
                        primary: theme.isDarkTheme
                        ? darkPrimaryBlue
                        : lightPrimaryBlue,
                        elevation: 0.0,
                        padding: EdgeInsets.all(40),
                        shape: CircleBorder(
                          side: BorderSide(
                            width: 6,
                            color: theme.isDarkTheme
                            ? darkAppBackgroundBlack
                            : lightAppBackgroundWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}