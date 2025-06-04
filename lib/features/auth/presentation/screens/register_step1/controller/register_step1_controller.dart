import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class RegisterStep1Controller extends ChangeNotifier {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void Function(String errorMessage)? onError;
  void Function()? onSuccess;

  Future<void> submitPhoneNumber(BuildContext context) async {
    final phone = phoneController.text.replaceAll(' ', '').trim();

    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      await LocalStorage.savePhone(phone);
      final id = AppConfig.libraryId.toString();

      context.read<RegisterStep1Bloc>().add(
        SubmitPhoneNumber(phoneNumber: phone, libraryId: id),
      );
    }
  }

  void handleState(RegisterStep1State state, BuildContext context) {
    if (state is RegisterFailure) {
      ToastMessage.showToast(state.message, context);
      isLoading = false;
      notifyListeners();
    } else if (state is RegisterSuccess) {
      isLoading = false;
      notifyListeners();
      AppNavigator.pushReplacementNamed(context, AppRoutes.registerVerify);
    }
  }

  void goToLogin(BuildContext context) {
    AppNavigator.pop(context);
  }

  @override
  void dispose() {
    phoneController.dispose();

    super.dispose();
  }
}
