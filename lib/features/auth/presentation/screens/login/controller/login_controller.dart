import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class LoginController extends ChangeNotifier {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final libraryId = AppConfig.libraryId.toString();
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
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
      isLoading = false;
      notifyListeners();
    } else if (state is LoginSuccess) {
      isLoading = false;
      notifyListeners();
      AppNavigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void disposeControllers() {
    phoneController.dispose();
    passwordController.dispose();
  }
}
