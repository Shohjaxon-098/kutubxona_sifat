import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step1/controller/register_step1_controller.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step1/widgets/register_step1_form.dart';
import 'package:provider/provider.dart';

class RegisterStep1Screen extends StatelessWidget {
  const RegisterStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterStep1Controller(),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: RegisterStep1Form(),
      ),
    );
  }
}
