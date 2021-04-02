import 'package:calculator_app/providers/country_list_provider.dart';
import 'package:calculator_app/providers/currency_calculator_provider.dart';
import 'package:calculator_app/screens/country_list/country_list_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../models/country.dart';
import '../../../custom/custom_colors.dart';
import '../../../providers/theme_provider.dart';

class CurrencyInput extends StatefulWidget {

  // final Country country;
  final bool isDesiredCurr;
  final bool isFromCountry;

  CurrencyInput({this.isDesiredCurr, this.isFromCountry});

  @override
  _CurrencyInputState createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {

  Country selectedCountry;

  final TextEditingController _currencyTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currencyTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final currencyCalculatorProvider = Provider.of<CurrencyCalculatorProvider>(context);
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    // final countryProvider = Country
    final Size mediaQuerySize = MediaQuery.of(context).size;

    Color textColor = Colors.white;
    Color borderColor = darkPrimaryBlue;

    if(!themeProvider.isDarkTheme && !widget.isDesiredCurr) {
      textColor = lightSecondaryBlack;
      borderColor = lightPrimaryBlue;
    } else if(themeProvider.isDarkTheme && !widget.isDesiredCurr) {
      textColor = darkSecondaryGrey;
    } else if(!themeProvider.isDarkTheme && !widget.isDesiredCurr) {
      textColor = lightSecondaryBlack;
    } else if(!themeProvider.isDarkTheme && widget.isDesiredCurr) {
      textColor = Colors.white;
      borderColor = Colors.white;
    } else if(themeProvider.isDarkTheme && widget.isDesiredCurr) {
      borderColor = Colors.white;
    }

    // if(selectedCountry.flagUrl == null && widget.isFromCountry) {
    //   selectedCountry.flagUrl = "https://www.countryflags.io/us/flat/64.png";
    // }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: mediaQuerySize.width * 0.4,
          child: InkWell(
            onTap: () async {
              Navigator.of(context).pushNamed(
                CountryListScreen.routeName,
                arguments: widget.isFromCountry,
              );
              // selectedCountry = await Navigator.pushNamed(context, CountryListScreen.routeName);
              // if(selectedCountry == null) {
              //   return;
              // }
              // if(widget.isFromCountry) {
              //   currencyCalculatorProvider.setFromCountryCode(selectedCountry.code);
              // } else {
              //   currencyCalculatorProvider.setToCountryCode(selectedCountry.code);
              // }
              // print("Selected Country is: $selectedCountry");
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: mediaQuerySize.width * 0.18,
                  height: mediaQuerySize.width * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image(
                    image: NetworkImage(
                      widget.isFromCountry
                      ? currencyCalculatorProvider.fromCountryFlagUri
                      : currencyCalculatorProvider.toCountryFlagUri,
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  widget.isFromCountry
                  ? currencyCalculatorProvider.fromCountry
                  : currencyCalculatorProvider.toCountry,
                  style: TextStyle(
                    fontFamily: "Viga",
                    fontSize: 24,
                    color: textColor,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: mediaQuerySize.width * 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  // onChanged: (_) {
                  //   print(_currencyTextController.text);
                  // },
                  onSubmitted: (val) {
                    print("Submitted Val: $val");
                  },
                  onEditingComplete: () {
                    print("Editing Complete: ${_currencyTextController.text}");
                  },
                  focusNode: FocusNode(
                    // canRequestFocus: false,
                  ),
                  controller: _currencyTextController,
                  maxLines: 1,
                  showCursor: true,
                  style: TextStyle(
                    fontFamily: "Viga",
                    fontSize: 48,
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2.5,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: themeProvider.isDarkTheme
                  ? darkPrimaryBlue
                  : lightPrimaryBlue,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: borderColor,
                      width: 2.5,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.check,
                  size: 25,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}