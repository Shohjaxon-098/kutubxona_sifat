import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  OtpInputFields({
    required this.controllers,
    required this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return OtpWidget(
          otpController: controllers[index],
          focusNode: focusNodes[index],
          nextNode: index < 5 ? focusNodes[index + 1] : null,
          previousNode: index > 0 ? focusNodes[index - 1] : null,
          isFirst: index == 0,
          isLast: index == 5,
        );
      }),
    );
  }
}
