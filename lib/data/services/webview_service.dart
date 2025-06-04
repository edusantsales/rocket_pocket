import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../env.dart';

/// WebViewService is a service class that manages the WebViewController and provides methods to set up and interact with the WebView.
/// It handles loading URLs, running JavaScript, and tracking the loading progress of the WebView.
class WebViewService {
  /// Singleton instance of WebViewService.
  factory WebViewService() => _instance;

  /// Private constructor for the singleton pattern.
  /// This constructor is private to prevent instantiation from outside the class.
  WebViewService._internal();

  /// WebViewController instance to manage the WebView.
  static final WebViewService _instance = WebViewService._internal();

  /// This controller is used to control the WebView, such as loading URLs, running JavaScript, etc.
  final WebViewController _controller = WebViewController();

  /// ValueNotifier to track the loading progress of the WebView.
  /// This is used to update the UI with the loading progress.
  /// It is initialized to 0, indicating no progress.
  /// The value will be updated as the WebView loads content.
  /// It is used in the UI to show a loading indicator while the WebView is loading.
  /// It is a ValueNotifier, which means it can notify listeners when the value changes.
  /// This allows the UI to reactively update when the loading progress changes.
  final ValueNotifier<int> loadingProgress = ValueNotifier<int>(0);

  /// Method to set up the WebView with the specified primary color.
  /// This method configures the WebViewController with various settings such as zoom, background color, scroll bar visibility, JavaScript mode, and navigation delegate.
  /// It also loads the base URL into the WebView.
  void setupWebView(Color primaryColor, VoidCallback setupJavaScripts) {
    _controller
      ..enableZoom(false)
      ..setBackgroundColor(primaryColor)
      ..setHorizontalScrollBarEnabled(false)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            loadingProgress.value = progress;
          },
          onPageStarted: (String url) {
            // Page started loading.
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Page finished loading.
            log('Page finished loading: $url');
            setupJavaScripts();
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
      ..loadRequest(Uri.parse(Env.baseUrl + Env.catalog));
  }

  /// Loads the URL into the WebView.
  Future<void> loadRequest(String path) async {
    try {
      await _controller.loadRequest(Uri.parse(Env.baseUrl + path));
    } catch (e) {
      log('Error loading URL: $e');
    }
  }

  /// Method to run JavaScript in the WebView.
  /// This method allows you to execute JavaScript code in the context of the WebView.
  Future<void> runJavaScript(String script) async {
    try {
      await _controller.runJavaScript(script);
    } catch (e) {
      log('Error running JavaScript: $e');
    }
  }

  /// Returns a WebViewWidget with the configured controller.
  Widget get webViewWidget {
    return WebViewWidget(controller: _controller);
  }
}
