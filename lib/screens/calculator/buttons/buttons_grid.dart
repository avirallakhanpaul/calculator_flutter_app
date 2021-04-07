import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../providers/calc_expression_provider.dart';
import '../../../providers/theme_provider.dart';
import '../buttons/button.dart';
import '../../../custom/custom_colors.dart';

class ButtonsGrid extends StatelessWidget {

  final List<String> buttons = [
    "AC",
    "del",
    "^",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "00",
    "=",
  ];

  @override
  Widget build(BuildContext context) {

    Color btnTextColor;

    final mediaQuerySize = MediaQuery.of(context).size;

    final calcProvider = Provider.of<CalcExpressionProvider>(context);

    bool isOperator(String btn) {
      if(btn == "/" || btn == "x" || btn == "-" || btn == "+") {
        return true;
      } else {
        return false;
      }
    }

    return Consumer<ThemeProvider>(
      builder: (ctx, theme, _) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: mediaQuerySize.width / mediaQuerySize.height * 2.25,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: buttons.length,
          itemBuilder: (ctx, index) {

            btnTextColor = theme.isDarkTheme
            ? darkSecondaryGrey
            : lightSecondaryBlack;

            var isOp = isOperator(buttons[index]);
            
            if(index == 0) { // AC
              return Button(
                btnText: buttons[index],
                btnTextColor: btnTextColor,
                isTapped: calcProvider.clearQuestion,
              );
            } else if(index == 1) { // del
              return Button(
                btnIcon: Icon(
                  Icons.backspace_outlined,
                  size: 30,
                  color: theme.isDarkTheme
                  ? darkSecondaryGrey
                  : lightSecondaryBlack,
                ),
                btnTextColor: btnTextColor,
                isTapped: calcProvider.deleteCharacter,
                isLongTapped: calcProvider.clearQuestion,
              );
            } else if(index == buttons.length - 1) { // =
              return Button(
                btnColor: theme.isDarkTheme
                ? darkPrimaryBlue
                : lightPrimaryBlue,
                btnText: buttons[index],
                btnTextColor: Colors.white,
                isEqualButton: true,
                isTapped: () => calcProvider.evaluateResult(calcProvider.question),
              );
            } else if(index == buttons.length - 2) { // 00
              return Button(
                btnText: buttons[index],
                btnTextColor: btnTextColor,
                isTapped: () => calcProvider.appendQuestion(buttons[index]),
              );
            } else if(isOp) { // All Operators
              return Button(
                btnText: buttons[index],
                // btnColor: theme.isDarkTheme
                // ? darkTertiaryGrey
                // : lightTertiaryGrey,
                btnTextColor: theme.isDarkTheme
                ? darkPrimaryBlue
                : lightPrimaryBlue,
                isTapped: () => calcProvider.appendQuestion(buttons[index]),
              );
            } else { // Numbers
              return Button(
                btnText: buttons[index],
                btnTextColor: btnTextColor,
                isTapped: () => calcProvider.appendQuestion(buttons[index]),
              );
            }
          },
        );
      }
    );
  }
}