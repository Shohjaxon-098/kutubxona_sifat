import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/book/data/datasources/review_remote_data_source.dart';
import 'package:kutubxona/features/book/data/repository/review_repository_impl.dart';
import 'package:kutubxona/features/book/domain/repository/review_repository.dart';
import 'package:kutubxona/features/book/domain/usecase/get_reviews_usecase.dart';
import 'package:kutubxona/features/book/domain/usecase/post_review_usecase.dart';
import 'package:kutubxona/features/category/presentation/logic/bloc/category_bloc.dart';
import 'package:kutubxona/features/connectivity/data/repositories/connectivity_repository_impl.dart';
import 'package:kutubxona/features/connectivity/domain/repositories/connectivity_repository.dart';
import 'package:kutubxona/features/connectivity/domain/usecases/watch_connection_usecase.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:kutubxona/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:kutubxona/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:kutubxona/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/user_profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: AppConfig.baseUrl)));

  // === OTP ===
  sl.registerFactory(() => OtpBloc(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(OtpRemoteDataSourceImpl(dio: sl())),
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
      remoteDataSource: BookDetailRemoteDataSourceImpl(dio: sl()),
    ),
  );
  // === Review ===
  sl.registerFactory(() => ReviewBloc(sl()));

  sl.registerLazySingleton(() => GetReviewsUseCase(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(sl()),
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
    () => LibraryRemoteDataSourceImpl(dio: sl()),
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
    () => UserProfileRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(sl()),
  );
  sl.registerFactory(() => CategoryBloc(sl()));

}
