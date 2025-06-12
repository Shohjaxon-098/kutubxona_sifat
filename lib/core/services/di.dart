import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kutubxona/core/network/auth_interceptor.dart';
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
import 'package:kutubxona/features/profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:kutubxona/features/profile/data/datasources/reserved_book_remote_datasource.dart';
import 'package:kutubxona/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:kutubxona/features/profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:kutubxona/features/profile/data/repositories/reserved_book_repository_impl.dart';
import 'package:kutubxona/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:kutubxona/features/profile/domain/repositories/edit_profile_repository.dart';
import 'package:kutubxona/features/profile/domain/repositories/reserved_book_repository.dart';
import 'package:kutubxona/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_reserved_books_usecase.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:kutubxona/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/reserved_book_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/edit_profile/edit_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/select_library/presentation/library_bloc/library_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
    dio.interceptors.add(AuthInterceptor(dio));
    return dio;
  });

  // === Connectivity ===
  sl.registerLazySingleton<ConnectivityRepository>(
    () => ConnectivityRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => WatchConnectionUseCase(sl()));

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

  // === Book Detail ===
  sl.registerFactory(() => BookDetailBloc(sl()));
  sl.registerLazySingleton(() => GetBookDetail(sl()));
  sl.registerLazySingleton<BookDetailRepository>(
    () => BookDetailRepositoryImpl(
      remoteDataSource: BookDetailRemoteDataSourceImpl(),
    ),
  );

  // === Review ===
  sl.registerFactory(() => ReviewBloc(sl()));
  sl.registerFactory(() => PostReviewBloc(sl()));
  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));
  sl.registerLazySingleton(() => PostReviewUseCase(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(),
  );

  // === Library ===
  sl.registerFactory(() => LibraryBloc(sl()));
  sl.registerLazySingleton(() => GetLibrariesUseCase(sl()));
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(),
  );

  // === User Profile ===
  sl.registerFactory(() => UserProfileBloc(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(),
  );

  // === Edit Profile ===
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );

  // === Reserved Books ===
  sl.registerFactory(() => ReservedBookBloc(sl()));
  sl.registerLazySingleton(() => GetReservedBooksUseCase(sl()));
  sl.registerLazySingleton<ReservedBookRepository>(
    () => ReservedBookRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ReservedBookRemoteDataSource>(
    () => ReservedBookRemoteDataSourceImpl(sl<Dio>()),
  );

  // === Book Reservation ===
  sl.registerFactory(() => ReserveBookBloc(sl()));
  sl.registerLazySingleton(() => ReserveBookUseCase(sl()));
  sl.registerLazySingleton<BookReserveRepository>(
    () => BookReserveRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<BookReserveRemoteDataSource>(
    () => BookReserveRemoteDataSourceImpl(),
  );

  // === Deficient Books ===
  sl.registerFactory(() => DeficientBooksCubit(sl()));
  sl.registerFactory(() => GetDeficientBooksUseCase(sl()));
  sl.registerFactory<DeficientBooksRemoteDataSource>(
    () => DeficientBooksRemoteDataSourceImpl(),
  );
  sl.registerFactory<DeficientBooksRepository>(
    () => DeficientBooksRepositoryImpl(sl()),
  );

  // === Drawer – About Us ===
  sl.registerFactory(() => AboutUsBloc(sl()));
  sl.registerLazySingleton(() => GetAboutUsUseCase(sl()));
  sl.registerLazySingleton<AboutUsRepository>(
    () => AboutUsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AboutUsRemoteDataSource>(
    () => AboutUsRemoteDataSourceImpl(),
  );

  // === Drawer – Statistic ===
  sl.registerFactory(() => StatisticBloc(sl()));
  sl.registerLazySingleton(() => GetStatisticsUseCase(sl()));
  sl.registerLazySingleton<StatisticRepository>(
    () => StatisticRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<StatisticRemoteDataSource>(
    () => StatisticRemoteDataSourceImpl(),
  );

  // === Drawer – Contribution ===
  sl.registerFactory(() => ContributionBloc(sl()));
  sl.registerLazySingleton(() => GetContributions(sl()));
  sl.registerLazySingleton<ContributionRepository>(
    () => ContributionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ContributionRemoteDataSource>(
    () => ContributionRemoteDataSourceImpl(),
  );

  // === Category ===
  sl.registerFactory(() => CategoryBloc(sl()));
}
