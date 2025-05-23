// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/formatters/phone_formatter.dart';

class PhoneTextfieldWidget extends StatelessWidget {
  const PhoneTextfieldWidget({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Мобил рақам',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.lerp(
                  Border(
                    bottom: BorderSide(color: AppColors().border),
                    top: BorderSide(color: AppColors().border),
                    left: BorderSide(color: AppColors().border),
                  ),
                  const Border(),
                  0,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Text(
                  '+998',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: phoneController,
                  cursorColor: AppColors().black,
                  cursorWidth: 1,
                  keyboardType: TextInputType.phone,
                  cursorHeight: 22,
                  style: const TextStyle(fontSize: 16),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12),
                    PhoneNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: TextStyle(
                      color: AppColors().hintColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: '_ _  _ _ _  _ _  _ _',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().border),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().border),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().border),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().border),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors().border),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
