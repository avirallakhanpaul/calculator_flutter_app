import "package:flutter/material.dart";

import 'screens/calculator/calculator_screen.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {

    return CalculatorScreen();
  }
}