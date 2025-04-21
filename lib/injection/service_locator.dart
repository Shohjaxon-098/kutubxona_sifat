import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/datasources/otp_remote_datasource.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/book_repository_impl.dart';
import 'package:kutubxona/features/kutubxona/data/repositories/otp_repository_impl.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/book_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/repository/otp_repository.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/searchs_book_usecases.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/verify_otp_usecase.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/search_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/otp/otp_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => OtpBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));

  // Repository
  sl.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(OtpRemoteDataSourceImpl(dio: Dio())),
  );
}

void setupSearch() {
  sl.registerFactory(() => SearchBloc(sl()));
  sl.registerLazySingleton(() => SearchBooks(sl()));
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(sl()));
  sl.registerLazySingleton(() => Dio(BaseOptions(baseUrl: baseUrl)));
}
