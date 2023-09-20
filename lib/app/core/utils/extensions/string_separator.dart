String addSeparator(List listItem, String sepatator) {
  String result = '';
  for (var element in listItem) {
    if (element[1] == true) {
      result += '$sepatator${element[0]}$sepatator';
    }
  }
  return result;
}

String strSeparator(List listItem, String sepatator) {
  String result = '';
  for (var element in listItem) {
    result += '$sepatator$element$sepatator';
  }
  return result;
}
