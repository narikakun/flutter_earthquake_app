import 'package:flutter/material.dart';

String ParseIntImage (String intA) {
  String intB = intA;
  switch(intA) {
    case "5-":
      intB = "5";
      break;
    case "5+":
      intB = "6";
      break;
    case "6-":
      intB = "7";
      break;
    case "6+":
      intB = "8";
      break;
    case "7":
      intB = "9";
      break;
  }
  return intB;
}

Color? ParseIntColor (String intA) {
  Map<String, Color> IntColor = {
    "1": const Color.fromRGBO(219, 219, 219, 1.0),
    "2": const Color.fromRGBO(196, 216, 252, 1.0),
    "3": const Color.fromRGBO(64, 64, 245, 1.0),
    "4": const Color.fromRGBO(255, 255, 198, 1.0),
    "5-": const Color.fromRGBO(255, 255, 103, 1.0),
    "5+": const Color.fromRGBO(244, 182, 87, 1.0),
    "6-": const Color.fromRGBO(239, 135, 132, 1.0),
    "6+": const Color.fromRGBO(234, 51, 35, 1.0),
    "7": const Color.fromRGBO(140, 26, 245, 1.0)
  };
  if (IntColor[intA] != null) {
    return IntColor[intA];
  } else {
    return const Color.fromRGBO(140, 140, 140, 1.0);
  }
}

Color? ParseTextIntColor (String intA) {
  Map<String, Color> IntTextColor = {
    "3": const Color.fromRGBO(255, 255, 255, 1.0),
    "6+": const Color.fromRGBO(255, 255, 255, 1.0),
    "7": const Color.fromRGBO(255, 255, 255, 1.0)
  };
  if (IntTextColor[intA] != null) {
    return IntTextColor[intA];
  } else {
    return const Color.fromRGBO(0, 0, 0, 1.0);
  }
}