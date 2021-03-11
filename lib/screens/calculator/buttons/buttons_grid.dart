import 'package:calculator_app/providers/calc_expression_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

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

    final calcProvider = Provider.of<CalcExpressionProvider>(context);

    bool isOperator(String btn) {
      if(btn == "/" || btn == "x" || btn == "-" || btn == "+") {
        return true;
      } else {
        return false;
      }
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.85 / 0.85,
        crossAxisSpacing: 5,
        mainAxisSpacing: 2,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      itemBuilder: (ctx, index) {

        var isOp = isOperator(buttons[index]);
        
        if(index == 0) { // AC
          return Button(
            btnText: buttons[index],
            btnTextSize: 32.0,
            isTapped: calcProvider.clearQuestion,
          );
        } else if(index == 1) { // del
          return Button(
            btnIcon: Icon(
              Icons.remove,
              size: 34.0,
              color: secondaryBlack,
            ),
            isTapped: calcProvider.deleteCharacter,
            isLongTapped: calcProvider.clearQuestion,
          );
        } else if(index == buttons.length - 1) { // =
          return Button(
            btnColor: primaryBlue,
            btnText: buttons[index],
            btnTextColor: Colors.white,
            isEqualButton: true,
            isTapped: () => calcProvider.evaluateResult(calcProvider.question),
          );
        } else if(index == buttons.length - 2) { // 00
          return Button(
            btnText: buttons[index],
            isTapped: () => calcProvider.appendQuestion(buttons[index]),
          );
        } else if(isOp) { // All Operators
          return Button(
            btnText: buttons[index],
            btnTextColor: primaryBlue,
            isTapped: () => calcProvider.appendQuestion(buttons[index]),
          );
        } else { // Numbers
          return Button(
            btnText: buttons[index],
            isTapped: () => calcProvider.appendQuestion(buttons[index]),
          );
        }
      },
    );
  }
}