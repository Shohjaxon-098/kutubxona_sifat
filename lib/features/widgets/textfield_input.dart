import 'package:flutter/services.dart';
import 'package:kutubxona/export.dart';

class TextFieldInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscure;
  final String? hint;
  final int? lengthInput;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final void Function()? onTap;
  final String? initialValue;
  final int? maxLength;

  const TextFieldInput({
    super.key,
    required this.label,
    this.controller,
    this.obscure = false,
    this.hint,
    this.lengthInput,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.readOnly,
    this.onTap,
    this.initialValue,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          maxLength: maxLength,
          readOnly: readOnly ?? false,
          controller: controller,
          obscureText: obscure,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          onChanged: onChanged,
          onTap: onTap,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, $label maydonini to‘ldiring';
                }
                return null;
              },
          inputFormatters: [
            if (lengthInput != null)
              LengthLimitingTextInputFormatter(lengthInput),
          ],
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            fontFamily: 'Roboto',
          ),
          cursorColor: Theme.of(context).colorScheme.tertiary,
          cursorWidth: 1,
          cursorHeight: 22.h,
          initialValue: initialValue,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 12.w,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 18.w,
              minHeight: 18.h,
            ),
            // constraints: BoxConstraints(minHeight: 50.h), // ⛔ Olib tashlandi
            suffixIcon: suffixIcon,
            isDense: true,
            hintText: hint,
            errorStyle: TextStyle(fontSize: 12.sp),
            hintStyle: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors().hintColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ],
    );
  }
}
