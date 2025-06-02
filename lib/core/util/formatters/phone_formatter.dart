import 'package:flutter/services.dart';

class FormatterUtil extends TextInputFormatter {
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

  String formatPhoneNumber(String rawPhone) {
    if (rawPhone.length != 9) return rawPhone; // fallback
    final part1 = rawPhone.substring(0, 2); // 50
    final part2 = rawPhone.substring(2, 5); // 779
    final part3 = rawPhone.substring(5, 7); // 14
    final part4 = rawPhone.substring(7); // 02

    return '+998 $part1 $part2 $part3 $part4';
  }
}
