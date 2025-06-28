import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/login/controller/login_controller.dart';
import 'widgets/login_button.dart';
import 'widgets/login_header.dart';
import 'widgets/login_password_field.dart';
import 'widgets/login_phone_field.dart';
import 'widgets/login_register_button.dart';
import 'widgets/login_telegram_button.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: const LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ bu ham kerak
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final controller = context.read<LoginController>();
          controller.handleState(context, state);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  SizedBox(height: 40.h),
                  LoginPhoneField(controller: controller.phoneController),
                  SizedBox(height: 8.h),
                  LoginPasswordField(controller: controller.passwordController),
                  SizedBox(height: 40.h),
                  LoginButton(
                    isLoading: controller.isLoading,
                    onPressed: () => controller.login(context),
                  ),
                  SizedBox(height: 12.h),
                  const LoginTelegramButton(),
                  SizedBox(height: 12.h),
                  const LoginRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
