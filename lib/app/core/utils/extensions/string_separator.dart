String addSeparator(List listItem, String sepatator) {
  String result = '';
  for (var element in listItem) {
    if (element[1] == true) {
      result += '$sepatator${element[0]}$sepatator';
    }
  }
  return result;
}
