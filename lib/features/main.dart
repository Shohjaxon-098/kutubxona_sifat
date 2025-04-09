import 'package:flutter/material.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/splash/splash_screen.dart';

void main() {
  runApp(const KutubxonaApp());
}

class KutubxonaApp extends StatelessWidget {
  const KutubxonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
