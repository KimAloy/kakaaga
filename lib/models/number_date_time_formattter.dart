import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final numberCommaFormatter = NumberFormat('###,###.##');

class DigitsInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    int value = int.parse(newValue.text);
    final formatter = NumberFormat('###,###.##');
    String newText = formatter.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
