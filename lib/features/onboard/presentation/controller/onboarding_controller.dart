import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_bloc.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_state.dart';

class OnboardingController extends ChangeNotifier {
  final BuildContext context;
  final PageController pageController = PageController();

  int currentIndex = 0;
  bool isLoading = false;
  bool isNavigated = false;

  OnboardingController(this.context) {
    _listenToBloc();
  }

  void _listenToBloc() {
    BlocProvider.of<LibraryBloc>(context).stream.listen((state) async {
      if (state is LibraryLoaded) {
        if (!isNavigated) {
          isNavigated = true;
          notifyListeners();
        }
      } else if (state is LibraryError) {
        isLoading = false;
        notifyListeners();
        ToastMessage.showToast('Xatolik yuz berdi: ${state.message}', context);
      }
    });
  }

  List<Map<String, String>> get pages => [
    {
      "image": AppImages().onBoard1,
      "text": "Китобларни уйингизга буюртма қилинг",
    },
    {"image": AppImages().onBoard2, "text": "Китобларни онлайн ўқинг"},
    {
      "image": AppImages().onBoard3,
      "text": "Китобларни аудио шаклини тингланг",
    },
  ];

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void goToLastPage() {
    pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void startApp() async {
    isLoading = true;
    notifyListeners();

    AppNavigator.pushNamedAndRemoveUntil(context, AppRoutes.selectRegion);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
