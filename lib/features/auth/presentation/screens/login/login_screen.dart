import 'package:kutubxona/features/auth/presentation/screens/login/controller/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:kutubxona/export.dart';
import 'widgets/login_button.dart';
import 'widgets/login_header.dart';
import 'widgets/login_password_field.dart';
import 'widgets/login_phone_field.dart';
import 'widgets/login_register_button.dart';
import 'widgets/login_telegram_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: controller.handleState,
        child: Form(
          key: controller.formKey,
          child: SafeArea(
            bottom: false,
            top: true,
            left: true,
            right: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 50),
                  LoginPhoneField(controller: controller.phoneController),
                  const SizedBox(height: 24),
                  LoginPasswordField(controller: controller.passwordController),
                  const SizedBox(height: 100),
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
