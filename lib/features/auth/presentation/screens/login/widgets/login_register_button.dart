import 'package:kutubxona/export.dart';

class LoginRegisterButton extends StatelessWidget {
  const LoginRegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
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
