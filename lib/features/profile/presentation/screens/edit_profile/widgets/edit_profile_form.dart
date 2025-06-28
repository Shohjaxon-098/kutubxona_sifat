import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/auth/presentation/logic/upload_image/upload_image_bloc.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/birth_date_picker_field.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/gender_dropdown.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'package:kutubxona/features/profile/presentation/logic/edit_profile/edit_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/edit_profile/edit_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/widgets/profile_image_picker.dart';
import 'package:kutubxona/features/widgets/primary_button.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _didSetInitial = false;
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _submitForm(EditProfileController controller) {
    final profile = controller.validateAndBuildModel(_formKey);
    if (profile != null) {
      Navigator.of(context).pop();
      context.read<UserProfileBloc>().add(GetUserProfileEvent());
      context.read<ProfileBloc>().add(UpdateProfileEvent(profile));
    }
  }

  @override
  void initState() {
    context.read<UserProfileBloc>().add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditProfileController>();

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoaded && !_didSetInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.setInitialValues(state.user);
          });
          _didSetInitial = true;
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Профилни ўзгартириш",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            centerTitle: true,
          ),
          body: BlocListener<UploadImageBloc, UploadImageState>(
            listener: (ctx, state) {
              if (state is UploadImageFailure) {
                ToastMessage.showToast(state.message, context);
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImagePicker(
                        imageFile: controller.photoFile,
                        imageUrl: controller.photoUrl,
                        onTap: controller.pickPhoto,
                      ),
                      SizedBox(height: 24.h),
                      CustomTextField(
                        keyboardType: TextInputType.name,
                        label: "Исмингиз",
                        controller: controller.nameController,
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? "Майдон тўлдирилиши шарт"
                                    : null,
                      ),
                      SizedBox(height: 16.h),
                      GenderDropdown(
                        selectedGender: controller.selectedGender,
                        onChanged: (g) => controller.selectedGender = g,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        label: "Парол",
                        controller: controller.passwordController,
                        hint: '********',
                        suffixIcon: GestureDetector(
                          onTap: toggleVisibility,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
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
                        validator:
                            (v) =>
                                v != null && v.length >= 6
                                    ? null
                                    : "Парол камида 6 та белгидан иборат бўлиши керак",
                        obscure: _obscureText,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.name,
                        label: "Фамилиянгиз",
                        controller: controller.surnameController,
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? "Майдон тўлдирилиши шарт"
                                    : null,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        label: "Телеграм username",
                        controller: controller.telegramController,
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? "Майдон тўлдирилиши шарт"
                                    : null,
                      ),
                      SizedBox(height: 16.h),
                      BirthDatePickerField(
                        controller: controller.birthDateController,
                        onTap: () => controller.pickBirthDate(context),
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? "Майдон тўлдирилиши шарт"
                                    : null,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Шахсий тасдиқловчи хужжат",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      DocumentTypeRadio(
                        groupValue: controller.verificationType,
                        onChanged:
                            (v) =>
                                controller.verificationType = v ?? 'passport',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        label:
                            controller.verificationType == 'passport'
                                ? "Паспорт маълумотлари *"
                                : "Гувоҳнома ID рақами *",
                        controller: controller.passportInfoController,
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? "Майдон тўлдирилиши шарт"
                                    : null,
                      ),
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
                            imageUrl: controller.docFrontUrl,
                            onTap: () => controller.pickDocument(true),
                          ),
                          SizedBox(width: 12.w),
                          ImagePickerBox(
                            file: controller.docBack,
                            imageUrl: controller.docBackUrl,
                            onTap: () => controller.pickDocument(false),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      if (controller.errorMessage != null)
                        Text(
                          controller.errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      SizedBox(height: 12.h),
                      PrimaryButton(
                        text: "Сақлаш",
                        onPressed: () => _submitForm(controller),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
