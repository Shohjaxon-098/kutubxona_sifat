import 'package:kutubxona/export.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final Function(bool) onLoading;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
    required this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      ttext:
          isLoading
              ? SizedBox(width: 26, height: 26,
                child: CircularProgressIndicator(
                  color: AppColors().white,
                  strokeWidth: 2,
                ),
              )
              : Text("Кириш", style: TextStyle(color: AppColors().white)),
      onPressed:
          isLoading
              ? null
              : () async {
                if (formKey.currentState?.validate() ?? false) {
                  onLoading(true);
                  final phone = phoneController.text.replaceAll(' ', '').trim();

                  final id = await AppConfig.libraryId.toString();

                  context.read<LoginBloc>().add(
                    LoginButtonPressed(
                      phoneNumber: phone,
                      password: passwordController.text,
                      libraryId: id,
                    ),
                  );
                }
              },
    );
  }
}
