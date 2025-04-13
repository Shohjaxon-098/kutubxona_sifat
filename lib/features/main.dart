import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_theme.dart';
import 'package:kutubxona/features/kutubxona/data/models/book.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/logic/bloc/book_search_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/splash/splash_screen.dart';

void main() {
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Book> offlineBooks = [
      Book(
        id: 1,
        name: "Alkimyogar",
        janr: 'Fantastika,Siyosat',
        year: 1768,
        rate: 4.2,
      ),
      Book(
        id: 2,
        name: "Shaytanat",
        janr: 'Fantastika,Siyosat',
        year: 1984,
        rate: 4.7,
      ),
      Book(
        id: 3,
        name: "Temur tuzuklari",
        janr: 'Fantastika,Siyosat',
        year: 1945,
        rate: 4.4,
      ),
      Book(
        id: 4,
        name: "Ikki eshik orasi",
        janr: 'Fantastika,Siyosat',
        year: 1923,
        rate: 5,
      ),
      Book(
        id: 5,
        name: "O‘tkan kunlar",
        janr: 'Fantastika,Siyosat',
        year: 1890,
        rate: 4.0,
      ),
      Book(
        id: 6,
        name: "Ufq",
        janr: 'Fantastika,Siyosat',
        year: 2000,
        rate: 4.4,
      ),
    ];
    return BlocProvider(
      create: (context) => BookSearchBloc(offlineBooks),
      child: MaterialApp(
        title: 'Kutubxona',
        theme: theme(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute, // Link routes
        initialRoute: AppRoutes.splash, // Set the initial route
      ),
    );
  }
}
