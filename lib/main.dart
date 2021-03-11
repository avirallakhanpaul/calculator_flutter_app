import 'package:calculator_app/providers/calc_expression_provider.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import 'custom/custom_colors.dart';
import 'root_page.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalcExpressionProvider>(
          create: (ctx) => CalcExpressionProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Viga",
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 42,
              color: secondaryBlack,
            ),
            bodyText2: TextStyle(
              color: primaryBlue,
            ),
          ), 
        ),
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}