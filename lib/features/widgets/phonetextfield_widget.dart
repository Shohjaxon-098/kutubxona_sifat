import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    _controller.addListener(() {
      if (mounted) setState(() {});
    });

    _focusNode.addListener(() {
      if (mounted && _focusNode.hasFocus) {
        setState(() {
          _isTapped = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showPrefix = _isTapped || _controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Мобил рақам',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          cursorColor: Theme.of(context).colorScheme.tertiary,
          cursorWidth: 1,
          cursorHeight: 22.h,
          keyboardType: TextInputType.phone,
          style: TextStyle(fontSize: 16.sp),
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
            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 12.w,
            ),

            prefixIcon:
                showPrefix
                    ? Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text('+998', style: TextStyle(fontSize: 16.sp)),
                    )
                    : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 0.w,
              minHeight: 0.h,
            ),
            constraints: BoxConstraints(minHeight: 50.h),
            isDense: true,
            helperText: ' ',
            hintText: showPrefix ? null : '+998  _ _  _ _ _  _ _  _ _',
            hintStyle: TextStyle(
              color: AppColors().hintColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            errorStyle: TextStyle(fontSize: 12.sp),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().border),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ],
    );
  }
}
