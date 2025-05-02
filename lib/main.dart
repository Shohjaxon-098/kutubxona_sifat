import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/book/data/datasources/book_detail_remote_data_source_impl.dart';
import 'package:kutubxona/features/book/data/repository/book_detail_repository_impl.dart';
import 'package:kutubxona/features/book/domain/usecase/get_book_detail.dart';
import 'package:kutubxona/features/book/presentation/bloc/book_detail_bloc.dart';
import 'package:kutubxona/features/home/presentation/home_screen.dart';
import 'package:kutubxona/core/services/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await di.init();
  await Hive.openBox('userBox'); // Open Hive box
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box('userBox');
    final bool isRegistered = userBox.get(
      'isRegistered',
      defaultValue: false,
    ); // Check registration status

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
        BlocProvider(create: (context) => sl<BookDetailBloc>()),
        BlocProvider(
          create: (_) => di.sl<LibraryBloc>()..add(FetchLibrariesEvent()),
        ),
        BlocProvider(
          create:
              (context) => BookDetailBloc(
                GetBookDetail(
                  BookDetailRepositoryImpl(
                    remoteDataSource: BookDetailRemoteDataSourceImpl(
                      dio: Dio(),
                    ),
                  ),
                ),
              ),
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
        home:
            isRegistered
                ? HomeScreen()
                : SplashScreen(), // Navigate based on registration status
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute:
            isRegistered
                ? AppRoutes.home
                : AppRoutes.splash, // Set initial route
        themeMode: ThemeMode.system,
      ),
    );
  }
}
