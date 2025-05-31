import 'package:kutubxona/app/connectivy_listener.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/logic/about_us/about_us_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/contribute_card.dart';
import 'package:kutubxona/features/home/domain/usecase/clear_filters_usecases.dart';
import 'package:kutubxona/features/home/presentation/logic/filter/filter_bloc.dart';

import 'package:kutubxona/core/services/di.dart' as di;
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => RegisterStep2Bloc(
                RegisterStep2Usecases(
                  repository: RegisterStep2RepositoryImpl(
                    remoteDataSource: RegisterStep2RemoteDataSourceImpl(),
                  ),
                ),
              ),
        ),

        BlocProvider(
          create:
              (context) => RegisterStep1Bloc(
                RegisterPhoneUseCase(
                  RegisterStep1RepositoryImpl(
                    remoteDataSource: RegisterStep1RemoteDataSourceImpl(),
                  ),
                ),
              ),
        ),
        BlocProvider<OtpBloc>(create: (_) => sl<OtpBloc>()),
        BlocProvider(create: (context) => TimerBloc()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<BookDetailBloc>()),
        BlocProvider(create: (context) => sl<ReviewBloc>()),
        BlocProvider(create: (context) => sl<PostReviewBloc>()),
        BlocProvider(create: (context) => sl<UserProfileBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(create: (context) => FilterBloc(ClearFiltersUseCase())),
        BlocProvider(create: (_) => sl<ConnectivityCubit>()),
        BlocProvider(create: (context) => sl<AboutUsBloc>()),
        BlocProvider(create: (context) => sl<StatisticBloc>()),
        BlocProvider(create: (context) => sl<ContributionBloc>()),
        BlocProvider(
          create: (_) => di.sl<LibraryBloc>()..add(FetchLibrariesEvent()),
        ),
        BlocProvider(
          create:
              (context) => BookDetailBloc(
                GetBookDetail(
                  BookDetailRepositoryImpl(
                    remoteDataSource: BookDetailRemoteDataSourceImpl(),
                  ),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => UploadImageBloc(
                uploadImageUseCase: UploadImageUseCase(
                  CommonRepositoryImpl(CommonRemoteDataSourceImpl()),
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
        theme: theme(context),
        darkTheme: darkTheme(),
        home: AppConnectivityOverlay(
          child: SplashScreen(),
        ), // Navigate based on registration status
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash, // Set initial route
        themeMode: ThemeMode.system,
        builder: (context, child) {
          return AppConnectivityOverlay(child: child!);
        },
      ),
    );
  }
}
