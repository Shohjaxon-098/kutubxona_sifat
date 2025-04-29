import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/search_bloc.dart';
import 'package:kutubxona/injection/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await di.init();
  await Hive.openBox('userBox');
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => RegisterStep2Bloc(
                RegisterStep2Usecases(
                  repository: RegisterStep2RepositoryImpl(
                    remoteDataSource: RegisterStep2RemoteDataSourceImpl(
                      dio: Dio(),
                    ),
                  ),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => RegisterStep1Bloc(
                RegisterPhoneUseCase(
                  RegisterStep1RepositoryImpl(
                    remoteDataSource: RegisterStep1RemoteDataSourceImpl(
                      dio: Dio(),
                    ),
                  ),
                ),
              ),
        ),
        BlocProvider<OtpBloc>(create: (_) => sl<OtpBloc>()),
        BlocProvider(create: (context) => TimerBloc()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(
          create: (_) => di.sl<LibraryBloc>()..add(FetchLibrariesEvent()),
        ),
        BlocProvider(
          create:
              (context) => UploadImageBloc(
                uploadImageUseCase: UploadImageUseCase(
                  CommonRepositoryImpl(CommonRemoteDataSourceImpl(Dio())),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => LoginBloc(
                loginUseCase: LoginUseCases(
                  LoginRepositoryImpl(
                    remoteDataSource: LoginRemoteDaraSourcesImpl(),
                  ),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Kutubxona',
        theme: theme(),
        darkTheme: darkTheme(),
        home: SelectRegion(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute, // Link routes
        initialRoute: AppRoutes.splash, // Set the initial route
        themeMode: ThemeMode.system,
      ),
    );
  }
}
