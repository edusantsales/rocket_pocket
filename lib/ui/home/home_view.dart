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
      _homeController.loadCatalogRequest();
      _homeController.setupWebView(Theme.of(context).primaryColor);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: false,
        elevation: 2,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                'assets/images/rocketseat-logo-transparent.png',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Rocket Pocket',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder<int>(
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
                Expanded(child: _homeController.webViewWidget)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: menuIndex,
        builder: (_, int currentIndex, __) {
          return BottomNavigationBar(
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
              BottomNavigationBarItem(
                backgroundColor: theme.primaryColor,
                icon: const Icon(Icons.settings_outlined),
                label: 'Minha conta',
              ),
              BottomNavigationBarItem(
                backgroundColor: theme.primaryColor,
                icon: const Icon(Icons.account_circle_outlined),
                label: 'Meu perfil',
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
                  case 2:
                    _homeController.loadMyAccountRequest();
                  case 3:
                    _homeController.loadMyProfileRequest();
                }
              }
            },
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            unselectedItemColor: Colors.white60,
            type: BottomNavigationBarType.shifting,
          );
        },
      ),
    );
  }
}
