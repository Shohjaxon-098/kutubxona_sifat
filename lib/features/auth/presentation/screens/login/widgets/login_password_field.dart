import 'package:kutubxona/export.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const LoginPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFieldInput(
      label: 'Парол',
      controller: controller,
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
}
