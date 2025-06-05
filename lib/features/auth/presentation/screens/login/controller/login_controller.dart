import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class LoginController extends ChangeNotifier {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final libraryId = AppConfig.libraryId.toString();
  bool isLoading = false;

  void login(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final bloc = context.read<LoginBloc>();
    bloc.add(
      LoginButtonPressed(
        phoneNumber: phoneController.text.replaceAll(' ', ''),
        password: passwordController.text,
        libraryId: libraryId,
      ),
    );
  }

  void handleState(BuildContext context, LoginState state) {
    if (state is LoginError) {
      ToastMessage.showToast(state.message, context);
      _stopLoading();
    } else if (state is LoginSuccess) {
      _stopLoading();
      AppNavigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
