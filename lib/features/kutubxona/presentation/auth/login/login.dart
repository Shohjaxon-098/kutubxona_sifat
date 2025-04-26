import 'package:flutter/material.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/services/local_storage.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/login/login_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/phonetextfield_widget.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/textfield_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 50),
                  _buildPhoneField(),
                  const SizedBox(height: 24),
                  _buildPasswordField(),
                  const SizedBox(height: 100),
                  _buildLoginButton(context),
                  const SizedBox(height: 12),
                  _buildTelegramLoginButton(),
                  const SizedBox(height: 12),
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Header qismi
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 5,
                  color: AppColors().cardShadow,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(AppImages().splashLogo),
                scale: 11,
              ),
            ),
          ),
          const SizedBox(height: 33),
          Text(
            'Ассалому алайкум\nХуш келибсиз!',
            style: TextStyle(
              color: AppColors().white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Telefon raqami uchun textfield
  Widget _buildPhoneField() {
    return PhoneTextfieldWidget(phoneController: phoneController);
  }

  // Parol uchun textfield
  Widget _buildPasswordField() {
    return TextFieldInput(
      label: 'Парол',
      controller: passwordController,
      hint: '********',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Parolni kiriting';
        } else if (value.length < 6) {
          return 'Parol kamida 6 ta belgidan iborat bo‘lishi kerak';
        }
        return null;
      },
    );
  }

  // Kirish tugmasi
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors().primaryColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () async {
        final phone = phoneController.text.trim();
        await LocalStorage.savePhone(phone);
        final id = await AppConfig.libraryId.toString();

        // ignore: use_build_context_synchronously

        if (_formKey.currentState?.validate() ?? false) {
          context.read<LoginBloc>().add(
            LoginButtonPressed(
              phoneNumber: phone,
              password: passwordController.text,
              libraryId: id,
            ),
          );
          AppNavigator.pushNamed(context, AppRoutes.home);
        }
      },
      child: Text("Кириш", style: TextStyle(color: AppColors().white)),
    );
  }

  // Telegram orqali kirish tugmasi
  Widget _buildTelegramLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: AppColors().primaryColor),
        backgroundColor: Theme.of(context).colorScheme.surface,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {},
      child: Text(
        "Телеграм орқали кириш",
        style: TextStyle(
          color: AppColors().primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Ro'yxatdan o'tish tugmasi
  Widget _buildRegisterButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        AppNavigator.pushNamed(context, AppRoutes.registerStep1Screen);
      },
      child: Text(
        "Рўйхатдан ўтиш",
        style: TextStyle(color: AppColors().primaryColor, fontSize: 15),
      ),
    );
  }
}
