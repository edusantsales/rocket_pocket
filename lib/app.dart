import 'package:flutter/material.dart';

import 'ui/home/home_view.dart';

class RocketPocketApp extends StatelessWidget {
  const RocketPocketApp({super.key});

  Color get primaryColor => const Color(0xFF8234E9);
  Color get primaryColorLight => const Color(0xFF9556F6);
  Color get backgroundColor => const Color(0xFF1A1A1E);
  Color get loadingColor => Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        fontFamily: 'Plus Jakarta Sans',
        indicatorColor: loadingColor,
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      title: 'Rocket Pocket',
    );
  }
}
