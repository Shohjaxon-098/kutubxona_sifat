import 'package:flutter/services.dart';
import 'package:kutubxona/core/util/important.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.otpController,

    required this.focusNode,
    this.nextNode,
    this.previousNode,
  });
  final TextEditingController otpController;

  final FocusNode focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: TextFormField(
          focusNode: focusNode,

          cursorHeight: 20,
          controller: otpController,

          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty && nextNode != null) {
              FocusScope.of(context).requestFocus(nextNode);
            } else if (value.isEmpty && previousNode != null) {
              FocusScope.of(context).requestFocus(previousNode);
            }
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            border: InputBorder.none,
            hintText: ('_'),
            hintStyle: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
