import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:hive_flutter/adapters.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/light_theme.dart';
import 'package:kutubxona/config/theme/dark_theme.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/splash/screens/splash_screen.dart';
import 'package:kutubxona/service/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterStep2Bloc(ApiService()),
      child: MaterialApp(
        title: 'Kutubxona',
        theme: theme(),
        darkTheme: darkTheme(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute, // Link routes
        initialRoute: AppRoutes.splash, // Set the initial route
        themeMode: ThemeMode.system,
      ),
    );
  }
}
