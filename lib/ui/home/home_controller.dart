import 'package:flutter/material.dart';

import '../../data/services/webview_service.dart';
import '../../env.dart';

class HomeController {
  final WebViewService webViewService = WebViewService();

  ValueNotifier<int> get webViewLoadingProgress => webViewService.loadingProgress;
  Widget get webViewWidget => webViewService.webViewWidget;

  void setupWebView(Color primaryColor) => webViewService.setupWebView(primaryColor, setupJavaScripts);

  void loadBaseURLRequest() => webViewService.loadRequest(Uri.parse(Env.baseURL));

  // Inject JavaScript into the WebView after a delay.
  // This method is called to set up the JavaScript functions that will hide certain UI elements in the Rocketseat app.
  // It uses a delay to ensure that the WebView has fully loaded before injecting the scripts.
  // The injected scripts hide the search button, Boost button, notifications button, and menu button, and disable bounce scroll physics in the WebView.
  // The scripts are run in parallel using Future.wait to improve performance.
  // This method is typically called after the WebView has finished loading the initial page.
  // It is important to ensure that the WebView is fully loaded before injecting the scripts, as injecting scripts too early may result in them not being applied correctly.
  Future<void> setupJavaScripts() async {
    await Future<void>.delayed(Durations.extralong4);
    Future.wait(<Future<void>>[
      webViewService.runJavaScript(hideSearchButton()),
      webViewService.runJavaScript(hideBoostButton()),
      webViewService.runJavaScript(hideNotificationsButton()),
      webViewService.runJavaScript(hideMenuButton()),
      webViewService.runJavaScript(disableBounceScrollPhysics()),
    ]);
  }

  // Hide the search button in the Rocketseat app.
  // This script is injected into the WebView to hide the search button after the page has loaded.
  String hideSearchButton() {
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[0].style.display = 'none';";
  }

// Hide the Boost button in the Rocketseat app.
// This script is injected into the WebView to hide the Boost button after the page has loaded.
  String hideBoostButton() {
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[1].style.display = 'none';";
  }

// Hide the notifications button in the Rocketseat app.
// This script is injected into the WebView to hide the notifications button after the page has loaded.
  String hideNotificationsButton() {
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[2].style.display = 'none';";
  }

// Hide the menu button in the Rocketseat app.
// This script is injected into the WebView to hide the menu button after the page has loaded.
  String hideMenuButton() {
    return "document.querySelectorAll('div.flex.shrink-0.items-center')[0].remove();";
  }

// Disable bounce scroll physics in the Rocketseat app.
// This script is injected into the WebView to disable bounce scroll physics after the page has loaded.
  String disableBounceScrollPhysics() {
    const String command1 = "document.body.style.overflow = 'hidden';";
    const String command2 = "document.documentElement.style.overflow = 'hidden';";
    const String command3 = """
      const style = document.createElement('style');
      style.innerHTML = `
        html, body {
          overscroll-behavior: none;
          -webkit-overflow-scrolling: auto !important;
          touch-action: none;
        }
      `;
      document.head.appendChild(style);
    """;
    const String commands = '$command1 $command2 $command3';
    return commands;
  }
}
