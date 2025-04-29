import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/home_remote_data_source.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/home_repository_impl.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/home_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/get_categories_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/search_books_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/search_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/home/home_bloc.dart';

// Bloc
import 'package:kutubxona/features/kutubxona/presentation/blocs/select_library/library_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/otp/otp_bloc.dart';

// Usecases
import 'package:kutubxona/features/kutubxona/domain/usecases/get_libraries_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/verify_otp_usecase.dart';

// Repository
import 'package:kutubxona/features/kutubxona/domain/repository/library_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/otp_repository.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/library_repository_impl.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/otp_repository_impl.dart';

// Data sources
import 'package:kutubxona/features/kutubxona/data/datasources/library_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/library_remote_datasource_impl.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/otp_remote_datasource.dart';

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

  // === Library ===
  sl.registerFactory(() => LibraryBloc(sl()));
  sl.registerLazySingleton(() => GetLibrariesUseCase(sl()));
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(dio: sl()),
  );
}
