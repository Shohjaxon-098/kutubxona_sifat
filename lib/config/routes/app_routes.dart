import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/screens/category_screen.dart';
import 'package:kutubxona/features/home/presentation/screens/home_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/booked_books_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:kutubxona/features/profile/presentation/screens/my_books_screen.dart';
import 'package:kutubxona/features/widgets/no_internet_widget.dart';

class AppRoutes {
  // Define route names
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String registerStep1Screen = '/registerStep1';
  static const String registerVerify = '/registerVerify';
  static const String onBoardScreen = '/onBoardScreen';
  static const String registerStep2Screen = '/registerStep2';
  static const String bookSearch = '/bookSearch';
  static const String categoryScreen = '/categoryScreen';
  static const String selectRegion = '/regionScreen';
  static const String bookDetail = '/bookDetail';
  static const String bookedBookScreen = '/bookedBookScreen';
  static const String myBookScreen = '/myBookScreen';
  static const String noInternetScreen = '/no-internet';
  static const String editProfile = '/editProfile';

  // Method to handle routing
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return PageTransition(
          isIos: true,
          child: const SplashScreen(),
          type: PageTransitionType.fade,
        );
      case noInternetScreen:
        return PageTransition(
          isIos: true,
          child: NoInternetScreen(),
          type: PageTransitionType.fade,
        );
      case home:
        return PageTransition(
          isIos: true,
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 400),
        );
      case login:
        return PageTransition(
          isIos: true,
          child: const Login(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case registerStep1Screen:
        return PageTransition(
          isIos: true,
          child: const RegisterStep1Screen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case onBoardScreen:
        return PageTransition(
          isIos: true,
          child: const OnboardingScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case registerStep2Screen:
        return PageTransition(
          isIos: true,
          child: const RegisterStep2Screen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case registerVerify:
        return PageTransition(
          isIos: true,
          child: const RegisterVerifyPage(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case selectRegion:
        return PageTransition(
          isIos: true,
          child: SelectRegionScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case categoryScreen:
        return PageTransition(
          isIos: true,
          child: const CategoryScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case bookedBookScreen:
        return PageTransition(
          isIos: true,
          child: BookedBooksPage(libraryId: AppConfig.libraryId.toString()),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case myBookScreen:
        return PageTransition(
          isIos: true,
          child: MyBooksScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      case editProfile:
        return PageTransition(
          isIos: true,
          child: EditProfileScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
