import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount, String currency) {
    final formatter = NumberFormat.currency(
      symbol: currency == 'EUR' ? '€' : '\$',
      decimalDigits: 0,
      locale: currency == 'EUR' ? 'es_ES' : 'en_US',
    );
    return formatter.format(amount);
  }
}
