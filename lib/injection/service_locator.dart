import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kutubxona/core/util/important.dart';

// Bloc
import 'package:kutubxona/features/kutubxona/presentation/blocs/select_library/library_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/search/search_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/otp/otp_bloc.dart';

// Usecases
import 'package:kutubxona/features/kutubxona/domain/usecases/get_libraries_usecase.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/searchs_book_usecases.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/verify_otp_usecase.dart';

// Repository
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/library_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/otp_repository.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/book_repository_impl.dart';
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

  // === Search ===
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerLazySingleton(() => SearchBooks(sl()));
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(sl()));

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
