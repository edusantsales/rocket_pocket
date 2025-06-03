import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _homeController.setupWebView(Theme.of(context).primaryColor);
      await Future<void>.delayed(Durations.extralong4 * 5);
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: theme.primaryColor, elevation: 0, toolbarHeight: 2),
      backgroundColor: theme.primaryColor,
      body: ValueListenableBuilder<int>(
        valueListenable: _homeController.webViewLoadingProgress,
        builder: (_, int progress, __) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (progress < 100)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Durations.extralong4,
                  builder: (_, double value, __) => LinearProgressIndicator(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    color: theme.indicatorColor,
                    minHeight: 2,
                    value: value,
                  ),
                ),
              Expanded(
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      _homeController.webViewWidget,
                      Positioned(
                        top: 2,
                        left: 2,
                        right: 72,
                        child: AppBar(backgroundColor: theme.scaffoldBackgroundColor, elevation: 0, toolbarHeight: 68),
                      ),
                      Positioned(
                        top: 12,
                        left: 14,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            // Handle logo tap, e.g., navigate to home or refresh.
                            onTap: () => _homeController.loadBaseURLRequest(),
                            child: Image.asset('assets/rocketseat-logo-transparent.png', width: 48, height: 48),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
