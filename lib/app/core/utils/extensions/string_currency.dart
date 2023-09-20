import 'package:intl/intl.dart';

class CurrencyFormat {
  static String toIdr(dynamic value, int digit) {
    NumberFormat formatted = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: digit,
    );
    return formatted.format(value);
  }
}
