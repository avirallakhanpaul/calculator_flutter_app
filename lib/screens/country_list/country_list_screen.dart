import 'package:calculator_app/models/country.dart';
import 'package:calculator_app/providers/country_list_provider.dart';
import 'package:calculator_app/providers/currency_calculator_provider.dart';
import 'package:calculator_app/providers/theme_provider.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CountryListScreen extends StatelessWidget {

  static const routeName = "/countriesList";

  // final bool isFromCountry;
  // CountryListScreen({
  //   this.isFromCountry,
  // });

  @override
  Widget build(BuildContext context) {

    final currencyCalcProvider = Provider.of<CurrencyCalculatorProvider>(context);
    final isFromCountry = ModalRoute.of(context).settings.arguments;

    void countrySelected(Country country) {
      isFromCountry ?
      currencyCalcProvider.setFromCountryCode(country.code, country.key)
      : currencyCalcProvider.setToCountryCode(country.code, country.key);

      Navigator.of(context).pop();
      // Navigator.of(context).pop(
      //   Country(
      //     code: country.code,
      //     flagUrl: country.flagUrl,
      //   ),
      // );
    }

    final countryProvider = Provider.of<CountryListProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<Country> countriesData = countryProvider.countries;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countries",
        ),
      ),
      body: ListView.builder(
        itemCount: countryProvider.countries.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ListTile(
            onTap: () {
              countrySelected(countryProvider.countries[index]);
            },
            leading: Container(
              child: Image(
                image: NetworkImage("${countriesData[index].flagUrl}"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            ),
            title: Text(
              countriesData[index].name,
              style: TextStyle(
                fontFamily: "Vega",
                fontSize: 22,
              ),
            ),
          );
        },
      ),
    );
  }
}