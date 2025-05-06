import 'package:kutubxona/export.dart';

class LoginTelegramButton extends StatelessWidget {
  const LoginTelegramButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      side: BorderSide(color: AppColors().primaryColor),
      color: Theme.of(context).colorScheme.surface,
      text: "Телеграм орқали кириш",
      textStyle: TextStyle(color: AppColors().primaryColor),
      onPressed: () {
        // TODO: Telegram login
      },
    );
  }
}
