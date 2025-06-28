import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/controller/register_step2_controller.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'widgets/gender_dropdown.dart';
import 'widgets/birth_date_picker_field.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  late RegisterStep2Controller controller;
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = RegisterStep2Controller(context: context);
  }

  @override
  void dispose() {
    controller.disposeController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterStep2Bloc, RegisterStep2State>(
          listener: (ctx, state) {
            if (state is RegisterStep2Failure) {
              ToastMessage.showToast(state.message, context);
            } else if (state is RegisterStep2Success) {
              Navigator.pushNamedAndRemoveUntil(
                ctx,
                AppRoutes.login,
                (route) => false,
              );
            }
          },
        ),
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (ctx, state) {
            if (state is UploadImageFailure) {
              ToastMessage.showToast(state.message, context);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Рўйхатдан ўтиш',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        label: "Исмингиз",
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        validator: validateRequired,
                        hint: 'Исмингиз',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "Фамилиянгиз",
                        controller: controller.surnameController,
                        keyboardType: TextInputType.name,
                        validator: validateRequired,
                        hint: 'Фамилиянгиз',
                      ),
                      SizedBox(height: 16.h),
                      GenderDropdown(
                        selectedGender: controller.selectedGender,
                        onChanged: (val) => controller.setGender(val),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "Парол",
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                        validator: validatePassword,
                        obscure: _obscureText,
                        hint: '******',
                        suffixIcon: GestureDetector(
                          onTap: toggleVisibility,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SvgPicture.asset(
                              width: 18.w,
                              height: 18.h,
                              _obscureText
                                  ? 'assets/icons/eye-hide.svg'
                                  : 'assets/icons/eye-show.svg',
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: "Телеграм username",
                        controller: controller.telegramController,
                        keyboardType: TextInputType.text,
                        validator: validateRequired,
                        hint: '@telegram_username',
                      ),
                      SizedBox(height: 16.h),
                      BirthDatePickerField(
                        controller: controller.birthDateController,
                        onTap: () => controller.pickBirthDate(),
                        validator: validateRequired,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Шахсий тасдиқловчи хужжат",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      DocumentTypeRadio(
                        groupValue: controller.documentType,
                        onChanged: (val) => controller.setDocumentType(val),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label:
                            controller.documentType == 'passport'
                                ? "Паспорт маълумотлари *"
                                : "Гувоҳнома ID рақами *",
                        controller: controller.passportInfoController,
                        keyboardType: TextInputType.text,
                        validator: validateRequired,
                        hint:
                            controller.documentType == 'passport'
                                ? 'AD1234567'
                                : 'I-NV 12345678',
                        lengthInput:
                            controller.documentType == 'passport' ? 9 : 12,
                      ),
                      if (controller.documentType == 'passport') ...[
                        SizedBox(height: 16.h),
                        Text(
                          "Ҳужжат расмини юкланг",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            ImagePickerBox(
                              file: controller.docFront,
                              onTap: () => controller.pickImage(true),
                            ),
                            SizedBox(width: 12.w),
                            ImagePickerBox(
                              file: controller.docBack,
                              onTap: () => controller.pickImage(false),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 24.h),
                      if (controller.apiErrorMessage != null)
                        Text(
                          controller.apiErrorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 13.sp),
                        ),
                      SizedBox(height: 12.h),
                      PrimaryButton(
                        onPressed:
                            controller.isLoading
                                ? null
                                : () => controller.submitForm(_formKey),
                        child:
                            controller.isLoading
                                ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors().white,
                                  ),
                                )
                                : Text(
                                  'Кириш',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: AppColors().white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
