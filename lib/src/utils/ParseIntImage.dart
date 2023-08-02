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