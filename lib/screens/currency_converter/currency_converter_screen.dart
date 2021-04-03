import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    super.initState();
    CountryListProvider();
  }

  @override
  Widget build(BuildContext context) {

    final Size mediaQuerySize = MediaQuery.of(context).size;
    final currCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);

    bool isDesiredCurrency = true;
    Color containerColor;

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
        return WillPopScope(
          onWillPop: () async {
            currCalcProvider.clearValues();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                            IconButton(
                              icon: Icon(
                                Icons.calculate_outlined,
                                size: 35,
                                color: theme.isDarkTheme
                                ? darkSecondaryGrey
                                : lightSecondaryBlack,
                              ),
                              splashRadius: 28,
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(CalculatorScreen.routeName);
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
                                    color: theme.isDarkTheme
                                    ? darkPrimaryBlue
                                    : lightPrimaryBlue,
                                  ),
                                  splashRadius: 28,
                                  onPressed: () {},
                                ),
                                Container(
                                  width: 30,
                                  height: 2,
                                  color: theme.isDarkTheme
                                  ? darkPrimaryBlue
                                  : lightPrimaryBlue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
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
                    ],
                  ),
                ),
              ],
            ),
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
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
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
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
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
                  left: mediaQuerySize.width / 2.8,
                  top: mediaQuerySize.height / 2.9,
                  child: ElevatedButton(
                    onPressed: () {
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
              ],
            ),
          ),
        );
      },
    );
  }
}