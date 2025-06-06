import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/logic/about_us/about_us_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/contribution/contribution_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/cubit/deficient_book_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_bloc.dart';

import 'package:kutubxona/core/services/di.dart' as di;
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/edit_profile/edit_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_bloc.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_event.dart';

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
        BlocProvider(create: (_) => sl<ConnectivityCubit>()),
        BlocProvider(create: (context) => sl<AboutUsBloc>()),
        BlocProvider(create: (context) => sl<StatisticBloc>()),
        BlocProvider(create: (context) => sl<ContributionBloc>()),
        BlocProvider(create: (context) => sl<ReserveBookBloc>()),
        BlocProvider(create: (context) => sl<DeficientBooksCubit>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),

        BlocProvider(create: (_) => sl<ReservedBookBloc>()),

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
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash, // Set initial route
        themeMode: ThemeMode.system,
      ),
    );
  }
}
