import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../custom/custom_colors.dart';
import '../../../providers/calc_expression_provider.dart';

class Result extends StatefulWidget {

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  Widget build(BuildContext context) {

    final calcProvider = Provider.of<CalcExpressionProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            calcProvider.question,
            style: TextStyle(
              fontSize: 32,
              color: lightSecondaryBlack,
            ),
          ),
          calcProvider.answer == "" 
          ? Container()
          : Text(
            calcProvider.answer,
            style: TextStyle(
              fontSize: 42,
              color: lightPrimaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}