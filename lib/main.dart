import 'package:feature_discovery/feature_discovery.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";

import 'providers/currency_calculator_provider.dart';
import 'providers/country_list_provider.dart';
import 'providers/calc_expression_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/country_list/country_list_screen.dart';
import 'screens/currency_converter/currency_converter_screen.dart';
import 'screens/calculator/calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalcExpressionProvider>(
          create: (ctx) => CalcExpressionProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider<CountryListProvider>(
          create: (ctx) => CountryListProvider(),
        ),
        ChangeNotifierProvider<CurrencyCalculatorProvider>(
          create: (ctx) => CurrencyCalculatorProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Nunito",
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          CalculatorScreen.routeName: (context) => CalculatorScreen(),
          CurrencyConverterScreen.routeName: (context) => CurrencyConverterScreen(),
          CountryListScreen.routeName: (context) => CountryListScreen(),
        },
        home: FeatureDiscovery(
          recordStepsInSharedPreferences: true,
          child: CalculatorScreen(),
        ),
      ),
    );
  }
}