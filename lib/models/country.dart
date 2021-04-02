import "package:flutter/material.dart";

class Country {
  final String key;
  final String name;
  final String code;
  final String flagUrl;
  // final String value;

  Country({
    this.key,
    this.name, 
    this.code, 
    this.flagUrl,
    // this.value,
  });

  // Country fromMapToMapString(Country country) {
  //   return Country(
  //     code: country.code,
  //     name: country.name,
  //     flagUrl: country.flagUrl,
  //   );
  // }
}