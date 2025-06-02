import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/data/datasources/book_reserve_remote_data_source.dart';
import 'package:kutubxona/features/book/data/datasources/review_remote_data_source.dart';
import 'package:kutubxona/features/book/data/repository/book_reserve_repository_impl.dart';
import 'package:kutubxona/features/book/data/repository/review_repository_impl.dart';
import 'package:kutubxona/features/book/domain/repository/book_reserved_repository.dart';
import 'package:kutubxona/features/book/domain/repository/review_repository.dart';
import 'package:kutubxona/features/book/domain/usecase/get_reviews_usecase.dart';
import 'package:kutubxona/features/book/domain/usecase/post_review_usecase.dart';
import 'package:kutubxona/features/book/domain/usecase/reserve_book_usecase.dart';
import 'package:kutubxona/features/book/presentation/logic/bloc/reserve_book_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_detail/book_detail_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/book_get_review/book_reviews_bloc.dart';
import 'package:kutubxona/features/book/presentation/logic/post_review/post_review_bloc.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/connectivity/data/repositories/connectivity_repository_impl.dart';
import 'package:kutubxona/features/connectivity/domain/repositories/connectivity_repository.dart';
import 'package:kutubxona/features/connectivity/domain/usecases/watch_connection_usecase.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/drawer/data/datasources/about_us_remote_datasource.dart';
import 'package:kutubxona/features/drawer/data/datasources/contribution_remote_data_source.dart';
import 'package:kutubxona/features/drawer/data/datasources/deficient_book_datasources.dart';
import 'package:kutubxona/features/drawer/data/datasources/statistic_remote_datasource.dart';
import 'package:kutubxona/features/drawer/data/repositories/about_us_repository_impl.dart';
import 'package:kutubxona/features/drawer/data/repositories/contribution_repository_impl.dart';
import 'package:kutubxona/features/drawer/data/repositories/deficient_repository_impl.dart';
import 'package:kutubxona/features/drawer/data/repositories/statistik_repository_impl.dart';
import 'package:kutubxona/features/drawer/domain/repositories/about_us_repository.dart';
import 'package:kutubxona/features/drawer/domain/repositories/contribution_repository.dart';
import 'package:kutubxona/features/drawer/domain/repositories/deficient_book_repository.dart';
import 'package:kutubxona/features/drawer/domain/repositories/statistic_repository.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_about_us_usecase.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_contributions.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_deficient_book_usecase.dart';
import 'package:kutubxona/features/drawer/domain/usecases/get_statistik_usecase.dart';
import 'package:kutubxona/features/drawer/presentation/logic/about_us/about_us_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/contribution/contribution_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/cubit/deficient_book_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_bloc.dart';
import 'package:kutubxona/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:kutubxona/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:kutubxona/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: AppConfig.baseUrl)));

  // === OTP ===
  sl.registerFactory(() => OtpBloc(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(OtpRemoteDataSourceImpl()),
  );
  // === Home ===
  sl.registerFactory(
    () => HomeBloc(getCategoriesUseCase: sl(), getBooksUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetBooksUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(HomeRemoteDataSource()),
  );
  // === Search ===
  sl.registerFactory(() => SearchBloc(sl()));

  sl.registerLazySingleton(() => SearchBooksUseCase(sl()));
  // === BookDetail ===
  sl.registerFactory(() => BookDetailBloc(sl()));
  sl.registerLazySingleton(() => GetBookDetail(sl()));
  sl.registerLazySingleton<BookDetailRepository>(
    () => BookDetailRepositoryImpl(
      remoteDataSource: BookDetailRemoteDataSourceImpl(),
    ),
  );
  // === Review ===
  sl.registerFactory(() => ReviewBloc(sl()));

  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(),
  );

  // === Review ===
  sl.registerFactory(() => PostReviewBloc(sl()));

  sl.registerLazySingleton(() => PostReviewUseCase(sl()));

  // === Library ===
  sl.registerFactory(() => LibraryBloc(sl()));
  sl.registerLazySingleton(() => GetLibrariesUseCase(sl()));
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // Qolganlar:
  sl.registerLazySingleton<ConnectivityRepository>(
    () => ConnectivityRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => WatchConnectionUseCase(sl()));
  sl.registerFactory(() => ConnectivityCubit(sl()));
  // === User Profile ===
  sl.registerFactory(() => UserProfileBloc(sl()));

  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(sl()),
  );
  sl.registerFactory(() => CategoryBloc(sl()));
  // BLoC
  sl.registerFactory(() => AboutUsBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetAboutUsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AboutUsRepository>(
    () => AboutUsRepositoryImpl(sl()),
  );

  // Remote DataSource
  sl.registerLazySingleton<AboutUsRemoteDataSource>(
    () => AboutUsRemoteDataSourceImpl(),
  );

  sl.registerFactory(() => StatisticBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetStatisticsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<StatisticRepository>(
    () => StatisticRepositoryImpl(sl()),
  );

  // Remote DataSource
  sl.registerLazySingleton<StatisticRemoteDataSource>(
    () => StatisticRemoteDataSourceImpl(),
  );

  sl.registerFactory(() => ContributionBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetContributions(sl()));

  // Repository
  sl.registerLazySingleton<ContributionRepository>(
    () => ContributionRepositoryImpl(sl()),
  );

  // Remote DataSource
  sl.registerLazySingleton<ContributionRemoteDataSource>(
    () => ContributionRemoteDataSourceImpl(),
  );

  // Data source
  sl.registerLazySingleton<BookReserveRemoteDataSource>(
    () => BookReserveRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<BookReserveRepository>(
    () => BookReserveRepositoryImpl(sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => ReserveBookUseCase(sl()));

  // Cubit
  sl.registerFactory(() => ReserveBookCubit(sl()));

  sl.registerFactory<DeficientBooksRemoteDataSource>(
    () => DeficientBooksRemoteDataSourceImpl(),
  );
  sl.registerFactory<DeficientBooksRepository>(
    () => DeficientBooksRepositoryImpl(sl()),
  );
  sl.registerFactory(() => GetDeficientBooksUseCase(sl()));
  sl.registerFactory(() => DeficientBooksCubit(sl()));
}
