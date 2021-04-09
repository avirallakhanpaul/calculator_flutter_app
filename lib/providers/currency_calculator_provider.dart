import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

const apiKey = "7d21954454b0317335ce";

class CurrencyCalculatorProvider with ChangeNotifier {

  String _fromCountry = "USD";
  String get fromCountry => _fromCountry;
  String _toCountry = "INR";
  String get toCountry => _toCountry;

  String _fromCountryFlagUri = "https://www.countryflags.io/us/flat/64.png";
  String get fromCountryFlagUri => _fromCountryFlagUri;
  String _toCountryFlagUri = "https://www.countryflags.io/in/flat/64.png";
  String get toCountryFlagUri => _toCountryFlagUri;

  String _value = "";
  String get value => _value;

  String _fromVal = "";
  String get fromVal => _fromVal;
  
  void setFromCountryCode(String countryCurrCode, {String countryKey}) {
    _fromCountry = countryCurrCode;
    _fromCountryFlagUri = "https://www.countryflags.io/$countryKey/flat/64.png";

    if(_fromVal.isNotEmpty && _fromCountry != _toCountry) {
      calculateConversionValue();
    }
    notifyListeners();
  }

  void setToCountryCode(String countryCurrCode, {String countryKey}) {
    _toCountry = countryCurrCode;
    _toCountryFlagUri = "https://www.countryflags.io/$countryKey/flat/64.png";

    if(_fromVal.isNotEmpty && _fromCountry != _toCountry) {
      calculateConversionValue();
    }
    notifyListeners();
  }

  void setFromVal(String val) {
    _fromVal = val.trim();
    notifyListeners();
  }

  void clearValues() {
    _value = "";
    _fromVal = "";
    notifyListeners();
  }

  void switchCurrencyValues() {
    var _tempFromCurr = _fromCountry;
    var _tempFromCountryFlag = _fromCountryFlagUri;
    setFromCountryCode(_toCountry);
    _fromCountryFlagUri = _toCountryFlagUri;
    setToCountryCode(_tempFromCurr);
    _toCountryFlagUri = _tempFromCountryFlag;
    calculateConversionValue();
    notifyListeners();
  }

  void calculateConversionValue() async {

    print("fromCountry: $_fromCountry");
    print("toCountry: $_toCountry");
    print("fromVal: $_fromVal");

    if(_fromVal == null || _fromVal.isEmpty) {
      return;
    }

    final Uri uri = Uri.parse("https://free.currconv.com/api/v7/convert?q=${_fromCountry}_$_toCountry&compact=ultra&apiKey=$apiKey");
    
    print("Getting currency value...");

    final response = await http.get(uri);
    final responseBody = jsonDecode(response.body);
    print("Response Body: $responseBody");
    print("Response Value: ${responseBody['${_fromCountry}_$_toCountry']}");
    final currVal = double.parse("${responseBody['${_fromCountry}_$_toCountry']}");
    _value = (currVal * double.parse(_fromVal)).toString();
    print("Value: $_value");
    notifyListeners();
  }
}