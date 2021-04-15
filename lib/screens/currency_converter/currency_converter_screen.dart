import 'package:calculator_app/custom/custom_appBar.dart';
import 'package:calculator_app/helpers/networkException.dart';
import 'package:calculator_app/screens/currency_converter/common/convert_button.dart';
import 'package:calculator_app/screens/currency_converter/common/error.dart';
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

  PreferredSize appBar;

  @override
  void initState() {
    super.initState();
    checkConnection();
    appBar = PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: FeatureDiscovery(
        child: CustomAppBar(isCalculator: false,)
      ),
    );
  }

  void checkConnection() async {
    try {
      var connectionResult = await (Connectivity().checkConnectivity());
      if(connectionResult == ConnectivityResult.none) {
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
    
    final currCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);

    bool isDesiredCurrency = true;
    Color containerColor;

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
        ? Error()
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
                  top: (mediaQuerySize.height / 2) - statusBarHeight - appBarHeight + 21,
                  child: FeatureDiscovery(
                    child: ConvertButton(),
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