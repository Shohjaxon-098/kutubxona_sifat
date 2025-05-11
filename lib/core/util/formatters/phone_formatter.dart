import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    final buffer = StringBuffer();
    int usedDigits = 0;
    int selectionIndex = newValue.selection.end;

    for (int i = 0; i < digitsOnly.length && usedDigits < 9; i++) {
      if (usedDigits == 2 || usedDigits == 5 || usedDigits == 7) {
        buffer.write(' ');
        if (i < selectionIndex) selectionIndex++;
      }
      buffer.write(digitsOnly[i]);
      usedDigits++;
    }

    final formatted = buffer.toString();

    // ⚠️ Kursor pozitsiyasi matndan oshmasligi kerak
    if (selectionIndex > formatted.length) {
      selectionIndex = formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
