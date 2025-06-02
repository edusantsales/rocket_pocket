import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'home_view.dart';

void main() {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  scheduleMicrotask(() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  });
  runApp(const RocketPocketApp());
}

class RocketPocketApp extends StatelessWidget {
  const RocketPocketApp({super.key});

  static Color get primaryColor => const Color(0xFF9556F6);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        primaryColor: primaryColor,
        useMaterial3: true,
      ),
      title: 'Rocket Pocket',
    );
  }
}
