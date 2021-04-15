import 'package:calculator_app/custom/custom_appBar.dart';
import 'package:feature_discovery/feature_discovery.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../custom/custom_colors.dart';
import 'buttons/buttons_grid.dart';
import 'result_window/result.dart';

class CalculatorScreen extends StatelessWidget {

  static const routeName = "/calculator";

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (ctx, theme, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: FeatureDiscovery(
              child: CustomAppBar(isCalculator: true,)
            ),
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