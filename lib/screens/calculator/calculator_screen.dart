import "package:flutter/material.dart";

import '../../custom/custom_colors.dart';
import 'buttons/buttons_grid.dart';
import 'result_window/result.dart';

class CalculatorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      backgroundColor: bckgndBlue,
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: mediaQuery.height * 0.215,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Result(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: ButtonsGrid(),
          ),
        ],
      ),
    );
  }
}