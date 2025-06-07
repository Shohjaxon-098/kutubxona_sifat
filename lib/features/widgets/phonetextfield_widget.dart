import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/formatters/phone_formatter.dart';

class PhoneTextfieldWidget extends StatefulWidget {
  const PhoneTextfieldWidget({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  State<PhoneTextfieldWidget> createState() => _PhoneTextfieldWidgetState();
}

class _PhoneTextfieldWidgetState extends State<PhoneTextfieldWidget> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.phoneController;
    _focusNode = FocusNode();
    if (!mounted) return;
    _controller.addListener(() {
      setState(() {});
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isTapped = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showPrefix = _isTapped || _controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Мобил рақам',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          cursorColor: AppColors().black,
          cursorWidth: 1,
          keyboardType: TextInputType.phone,
          cursorHeight: 22,
          style: const TextStyle(fontSize: 16),
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
            PhoneNumberFormatter(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Мобил рақамни киритинг';
            } else if (value.length < 12) {
              return 'Мобил рақам тўлиқ эмас';
            }
            return null;
          },
          decoration: InputDecoration(
            prefixIcon:
                showPrefix
                    ? Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text('+998', style: const TextStyle(fontSize: 16)),
                    )
                    : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            constraints: const BoxConstraints(minHeight: 50),
            errorStyle: const TextStyle(fontSize: 12),
            helperText: ' ',
            isDense: true,
            hintText:
                showPrefix
                    ? null // ✅ prefix chiqsa, hintdagi +998 yo‘qoladi
                    : '+998  _ _  _ _ _  _ _  _ _',
            hintStyle: TextStyle(
              color: AppColors().hintColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
