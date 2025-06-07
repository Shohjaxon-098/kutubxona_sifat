import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpPinput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onCompleted;

  const OtpPinput({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = Theme.of(context).colorScheme.tertiary;
    final borderColor = Theme.of(context).colorScheme.tertiary;

    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: TextStyle(
        fontSize: 22,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        separatorBuilder: (index) => const SizedBox(width: 8),
        onCompleted: onCompleted,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}
