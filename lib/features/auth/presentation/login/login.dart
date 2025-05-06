import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_button.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_header.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_password_field.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_phone_field.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_register_button.dart';
import 'package:kutubxona/features/auth/presentation/login/widgets/login_telegram_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            setState(() => _isLoading = false);
            ToastMessage.show(state.message);
          }
          if (state is LoginSuccess) {
            setState(() => _isLoading = false);
            AppNavigator.pushNamed(context, AppRoutes.home);
          }
        },
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 50),
                  LoginPhoneField(controller: phoneController),
                  const SizedBox(height: 24),
                  LoginPasswordField(controller: passwordController),
                  const SizedBox(height: 100),
                  LoginButton(
                    isLoading: _isLoading,
                    formKey: _formKey,
                    phoneController: phoneController,
                    passwordController: passwordController,
                    onLoading: (bool loading) {
                      setState(() => _isLoading = loading);
                    },
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
