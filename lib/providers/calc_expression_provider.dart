import "package:flutter/material.dart";
import 'package:math_expressions/math_expressions.dart';

class CalcExpressionProvider extends ChangeNotifier {

  String question = "";
  String answer = "";
  String historyQuestion = "";

  bool flag = false;
  bool isBracket = false;

  void appendQuestion(String key) { // For all Numbers

    if(key == "()") {
      if(!isBracket) { // No Bracket
        key = "(";
        isBracket = true;
      } else { // Bracket
        key = ")";
        isBracket = false;
      }
    }

    if(answer != "" && flag) {
      question = answer + key;
      flag = false;
    } else {
      question = question + key;
    }
    notifyListeners();
  }

  void clearQuestion() { // For AC
    question = "";
    answer = "";
    notifyListeners();
  }

  void deleteCharacter() { // For Del

    if(question.isEmpty) {
      return;
    } else {
      question = question.substring(0, question.length - 1);
      notifyListeners();
    }
  }

  // void factorial(String number) {
  //   for(int i = int.parse(number) - 1; i > 0; i--) {
  //     question = int.parse(number * i).toString();
  //     evaluateResult(question);
  //   }
  // }

  void evaluateResult(String expression) {

    if(expression == null) {
      return;
    }

    final formattedExp = expression.replaceAll(RegExp(r"x"), "*");
    print("Expression after formartting: $expression");

    Parser p = Parser();
    Expression exp = p.parse(formattedExp);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();

    flag = true;
    notifyListeners();
  }
}