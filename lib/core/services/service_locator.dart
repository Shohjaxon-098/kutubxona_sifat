import 'package:kutubxona/core/util/important.dart';


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
