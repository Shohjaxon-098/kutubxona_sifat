import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/splash/splash_screen.dart';

void main() {
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
