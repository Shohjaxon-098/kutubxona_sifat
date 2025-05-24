import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class PhoneChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Text(
        'Телефон рақамни ўзгартириш',
        style: TextStyle(
          color: AppColors().blue,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
