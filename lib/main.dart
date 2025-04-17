import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kutubxona/config/theme/light_theme.dart';
import 'package:kutubxona/config/theme/dark_theme.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/register_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/register_step1_repository_impl.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/otp_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/register_phone_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/otp_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step1/register_step1_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterStep2Bloc(ApiService())),
        BlocProvider(
          create:
              (context) => RegisterStep1Bloc(
                RegisterPhoneUseCase(
                  RegisterStep1RepositoryImpl(
                    remoteDataSource: RegisterRemoteDataSourceImpl(dio: Dio()),
                  ),
                ),
              ),
        ), 
        BlocProvider(create: (context) => TimerBloc()),
      ],
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
