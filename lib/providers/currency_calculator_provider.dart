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

  void setFromCountryCode(String countryCurrCode, String countryKey) {
    _fromCountry = countryCurrCode;
    _fromCountryFlagUri = "https://www.countryflags.io/$countryKey/flat/64.png";
    notifyListeners();
  }

  void setToCountryCode(String countryCurrCode, String countryKey) {
    _toCountry = countryCurrCode;
    _toCountryFlagUri = "https://www.countryflags.io/$countryKey/flat/64.png";
    notifyListeners();
  }

  // void setFromCountryFlagUri(String cCode) {
  //   _fromCountryFlagUri = "https://www.countryflags.io/$cCode/flat/64.png";
  //   notifyListeners();
  // }

  // void setToCountryFlagUri(String cCode) {
  //   _fromCountryFlagUri = "https://www.countryflags.io/$cCode/flat/64.png";
  //   notifyListeners();
  // }

  void calculateConversionValue() async {

    final Uri uri = Uri.parse("https://free.currconv.com/api/v7/convert?q=${_fromCountry}_${_toCountry}&compact=ultra&apiKey=$apiKey");

    final response = await http.get(uri);
    final responseBody = jsonDecode(response.body);
    print("Response Body: $responseBody");
  }
}