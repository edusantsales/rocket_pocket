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

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
      title: 'Rocket Pocket',
    );
  }
}
