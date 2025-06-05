import 'package:flutter/material.dart';
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
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // Har doim controllerni .read bilan olib, mounted tekshirish shart emas
          final controller = context.read<LoginController>();
          controller.handleState(context, state);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 50),
                  LoginPhoneField(controller: controller.phoneController),
                  const SizedBox(height: 8),
                  LoginPasswordField(controller: controller.passwordController),
                  const Spacer(),
                  LoginButton(
                    isLoading: controller.isLoading,
                    onPressed: () => controller.login(context),
                  ),
                  const SizedBox(height: 12),
                  const LoginTelegramButton(),
                  const SizedBox(height: 12),
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
