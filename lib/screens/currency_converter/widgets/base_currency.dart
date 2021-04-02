import "package:flutter/material.dart";

import '../common/currency_input.dart';

class BaseCurrency extends StatefulWidget {

  @override
  _BaseCurrencyState createState() => _BaseCurrencyState();
}

class _BaseCurrencyState extends State<BaseCurrency> {

  @override
  Widget build(BuildContext context) {
    return CurrencyInput();
  }
}