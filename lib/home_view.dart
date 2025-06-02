import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_controller.dart';
import 'main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = HomeController();
  final WebViewController _webViewController = WebViewController();

  Future<void> _setupJavaScripts() async {
    await Future<void>.delayed(Durations.extralong4);
    Future.wait(<Future<void>>[
      _webViewController.runJavaScript(_homeController.hideSearchButton()),
      _webViewController.runJavaScript(_homeController.hideBoostButton()),
      _webViewController.runJavaScript(_homeController.hideNotificationsButton()),
      _webViewController.runJavaScript(_homeController.hideMenuButton()),
      _webViewController.runJavaScript(_homeController.disableBounceScrollPhysics()),
    ]);
  }

  void _setupWebView() {
    _webViewController
      ..enableZoom(false)
      ..setBackgroundColor(RocketPocketApp.primaryColor)
      ..setHorizontalScrollBarEnabled(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            _homeController.loadingProgress.value = progress;
          },
          onPageStarted: (String url) {
            // Page started loading.
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Page finished loading.
            log('Page finished loading: $url');
            _setupJavaScripts();
          },
          onHttpError: (HttpResponseError error) {
            // Handle HTTP error.
            log('HTTP error: ${error.response?.statusCode} for URL: ${error.response?.uri?.path}');
            log('Response: ${error.response?.uri}');
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error.
            log('Web resource error: ${error.description} for URL: ${error.url}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle navigation request.
            log('Navigation request: ${request.url}');
            // if (!request.url.startsWith(baseURL)) {
            //   // If the URL does not match the base URL, reload it.
            //   _webViewController.loadRequest(Uri.parse(baseURL));
            //   return NavigationDecision.prevent;
            // }
            // https://app.rocketseat.com.br/login
            // Page started loading: https://github.com/login/oauth/authorize
            // Page finished loading: https://app.rocketseat.com.br/github/
            // Navigation request: https://github.com/login/oauth/authorize
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_homeController.baseURL));
  }

  @override
  void initState() {
    _setupWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ValueListenableBuilder<int>(
        valueListenable: _homeController.loadingProgress,
        builder: (BuildContext context, int progress, Widget? child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (child != null) Expanded(child: child) else const SizedBox.shrink(),
              if (progress < 100)
                LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: RocketPocketApp.primaryColor,
                  minHeight: 4,
                  value: progress / 100,
                ),
            ],
          );
        },
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              WebViewWidget(controller: _webViewController),
              Positioned(
                top: 14,
                left: 14,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // Handle logo tap, e.g., navigate to home or refresh.
                      _webViewController.loadRequest(Uri.parse(_homeController.baseURL));
                    },
                    child: Image.asset(
                      'assets/rocketseat-logo-transparent.png',
                      width: 46,
                      height: 44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
