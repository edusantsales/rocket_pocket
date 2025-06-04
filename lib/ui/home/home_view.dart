import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = HomeController();

  ValueNotifier<int> menuIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.setupWebView(Theme.of(context).primaryColor);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: theme.primaryColor, elevation: 0, toolbarHeight: 2),
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
                        top: 4,
                        left: 4,
                        right: 72,
                        child: AppBar(backgroundColor: Colors.transparent, elevation: 0, toolbarHeight: 56),
                      ),
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 24,
                        child: ValueListenableBuilder<int>(
                          valueListenable: menuIndex,
                          builder: (_, int currentIndex, __) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: BottomNavigationBar(
                                backgroundColor: theme.primaryColor,
                                currentIndex: currentIndex,
                                elevation: 0,
                                items: <BottomNavigationBarItem>[
                                  BottomNavigationBarItem(
                                    backgroundColor: theme.primaryColor,
                                    icon: const Icon(Icons.menu_book_outlined),
                                    label: 'Catálogo',
                                  ),
                                  BottomNavigationBarItem(
                                    backgroundColor: theme.primaryColor,
                                    icon: const Icon(Icons.collections_bookmark_outlined),
                                    label: 'Meus conteúdos',
                                  ),
                                ],
                                onTap: (int index) {
                                  menuIndex.value = index;
                                  if (currentIndex != index) {
                                    switch (index) {
                                      case 0:
                                        _homeController.loadCatalogRequest();
                                      case 1:
                                        _homeController.loadMyContentRequest();
                                    }
                                  }
                                },
                                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
                                selectedItemColor: Colors.white,
                                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                                unselectedItemColor: Colors.white60,
                                type: BottomNavigationBarType.shifting,
                              ),
                            );
                          },
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
