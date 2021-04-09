import 'dart:convert';

import 'package:calculator_app/helpers/networkException.dart';
import "package:flutter/material.dart";
import "package:connectivity/connectivity.dart";

import '../models/country.dart';
import "package:http/http.dart" as http;

const apiKey = "7d21954454b0317335ce";

class CountryListProvider extends ChangeNotifier {

  CountryListProvider() {
    print("Calling getCountries...");
    getCountries();
  }

  List<Country> _countries = [];
  List<Country> get countries => _countries;
  
  final Uri uri = Uri.parse("https://free.currconv.com/api/v7/countries?apiKey=$apiKey");

  // Future<void> init() async {
  //   try {
  //     await getCountries();
  //   } catch(e) {
  //     print("E: $e");
  //   }
  // }

  void getCountries() async {

    try {
      var connectionResult = await (Connectivity().checkConnectivity());
      if(connectionResult == ConnectivityResult.none) {
        print("No internet found");
        throw NetworkException(errorText: "No Internet Found, please try again later");
      } else {
        final response = await http.get(uri);
        final responseBody = await jsonDecode(response.body);
        final Map<String, dynamic> currMap = responseBody["results"];

        currMap.forEach((key, value) {
          _countries.add(
            Country(
              key: key,
              name: value["name"],
              code: value["currencyId"],
              currencyName: value["currencyName"],
              currencySymbol: value["currencySymbol"],
              flagUrl: "https://www.countryflags.io/$key/flat/64.png",
            ),
          );
        });

        _countries.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });

        print("Countries:- ${_countries.length}");
        notifyListeners();
      }
    } catch(e) {
      print("Exception caught: $e");
    }
  }
}