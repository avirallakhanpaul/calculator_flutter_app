import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import '../../providers/country_list_provider.dart';
import '../../providers/currency_calculator_provider.dart';
import '../../providers/theme_provider.dart';
import "../../models/country.dart";
import '../../custom/custom_colors.dart';

class CountryListScreen extends StatelessWidget {

  static const routeName = "/countriesList";
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    
    final currencyCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);
    final countryProvider = Provider.of<CountryListProvider>(context);
    final isFromCountry = ModalRoute.of(context).settings.arguments;

    final List<Country> countriesData = countryProvider.countries;
    
    void countrySelected(Country country) {
      isFromCountry ?
      currencyCalcProvider.setFromCountryCode(
        country.code, 
        countryKey: country.key
      )
      : currencyCalcProvider.setToCountryCode(
        country.code,
        countryKey: country.key
      );
      Navigator.of(context).pop();
      // Navigator.of(context).pushReplacementNamed(CurrencyConverterScreen.routeName);
    }

    return Consumer<ThemeProvider>(
      builder: (ctx, theme, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Countries",
              style: TextStyle(
                fontSize: 20,
                color: theme.isDarkTheme 
                ? darkSecondaryGrey
                : lightSecondaryBlack,
              ),
            ),
            brightness: theme.isDarkTheme 
            ? Brightness.dark
            : Brightness.light,
            backgroundColor: theme.isDarkTheme 
            ? darkAppBackgroundBlack
            : lightAppBackgroundWhite,
            // leading: IconButton(
            //   onPressed: () => Navigator.of(context).pushReplacementNamed(CurrencyConverterScreen.routeName),
            //   icon: Icon(
            //     Icons.arrow_back_rounded,
            //     color: theme.isDarkTheme 
            //     ? darkSecondaryGrey
            //     : lightSecondaryBlack,
            //   ),
            // ),
            actionsIconTheme: IconThemeData(
              color: theme.isDarkTheme
              ? Colors.white
              : Colors.black,
            ),
            iconTheme: IconThemeData(
              color: theme.isDarkTheme
              ? darkSecondaryGrey
              : lightSecondaryBlack,
            ),
          ),
          backgroundColor: theme.isDarkTheme 
          ? darkAppBackgroundBlack
          : lightAppBackgroundWhite,
          body: DraggableScrollbar.semicircle(
            // labelTextBuilder: (double offset) {
            //   return Text("");
            // },
            backgroundColor: theme.isDarkTheme
            ? darkSecondaryGrey
            : lightSecondaryBlack,
            heightScrollThumb: 50,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: countryProvider.countries.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        countrySelected(countryProvider.countries[index]);
                      },
                      leading: Container(
                        child: Image(
                          image: NetworkImage("${countriesData[index].flagUrl}"),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          width: 45,
                        )
                      ),
                      title: Text(
                        countriesData[index].name,
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.isDarkTheme 
                          ? darkSecondaryGrey
                          : lightSecondaryBlack,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "${countriesData[index].currencyName}\t(${countriesData[index].currencySymbol})",
                              style: TextStyle(
                                fontSize: 18,
                                color: theme.isDarkTheme 
                                ? darkPrimaryBlue
                                : lightSecondaryBlack,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
    );
  }
}