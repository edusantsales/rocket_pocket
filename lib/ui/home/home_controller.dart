import 'package:flutter/material.dart';

import '../../data/services/webview_service.dart';
import '../../env.dart';

class HomeController {
  final WebViewService _webViewService = WebViewService();

  ValueNotifier<int> get webViewLoadingProgress => _webViewService.loadingProgress;
  Widget get webViewWidget => _webViewService.webViewWidget;

  void setupWebView(Color primaryColor) => _webViewService.setupWebView(primaryColor, setupJavaScripts);

  void loadCatalogRequest() => _webViewService.loadRequest(Env.catalog);
  void loadMyContentRequest() => _webViewService.loadRequest(Env.myContent);
  void loadMyAccountRequest() => _webViewService.loadRequest(Env.account);
  void loadMyProfileRequest() => _webViewService.loadRequest(Env.profile);

  // Inject JavaScript into the WebView after a delay.
  // This method is called to set up the JavaScript functions that will hide certain UI elements in the Rocketseat app.
  // It uses a delay to ensure that the WebView has fully loaded before injecting the scripts.
  // The injected scripts hide the search button, Boost button, notifications button, and menu button, and disable bounce scroll physics in the WebView.
  // The scripts are run in parallel using Future.wait to improve performance.
  // This method is typically called after the WebView has finished loading the initial page.
  // It is important to ensure that the WebView is fully loaded before injecting the scripts, as injecting scripts too early may result in them not being applied correctly.
  Future<void> setupJavaScripts() async {
    await Future.wait(<Future<void>>[
      // webViewService.runJavaScript(hideSearchButton()),
      // webViewService.runJavaScript(hideBoostButton()),
      // webViewService.runJavaScript(hideNotificationsButton()),
      // webViewService.runJavaScript(hideMenuButton()),
      _webViewService.runJavaScript(disableBounceScrollPhysics()),
      _webViewService.runJavaScript(hideHeader()),
    ]);
  }

  // Hide the search button in the Rocketseat app.
  // This script is injected into the WebView to hide the search button after the page has loaded.
  String hideSearchButton() {
    // The first button in the list is the search button, which we want to hide.
    // The buttons are selected using a CSS selector that targets all buttons within a specific div structure.
    // The style.display property is set to 'none' to hide the button.
    // This is useful for users who do not want to see the search button in the Rocketseat app.
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[0].style.display = 'none';";
  }

  // Hide the Boost button in the Rocketseat app.
  // This script is injected into the WebView to hide the Boost button after the page has loaded.
  String hideBoostButton() {
    // The second button in the list is the Boost button, which we want to hide.
    // The buttons are selected using a CSS selector that targets all buttons within a specific div structure.
    // The style.display property is set to 'none' to hide the button.
    // This is useful for users who do not want to see the Boost button in the Rocketseat app.
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[1].style.display = 'none';";
  }

  // Hide the notifications button in the Rocketseat app.
  // This script is injected into the WebView to hide the notifications button after the page has loaded.
  String hideNotificationsButton() {
    // The third button in the list is the notifications button, which we want to hide.
    // The buttons are selected using a CSS selector that targets all buttons within a specific div structure.
    // The style.display property is set to 'none' to hide the button.
    // This is useful for users who do not want to see notifications in the Rocketseat app.
    return "document.querySelectorAll('div.flex.items-center.gap-3 button')[2].style.display = 'none';";
  }

  // Hide the menu button in the Rocketseat app.
  // This script is injected into the WebView to hide the menu button after the page has loaded.
  String hideMenuButton() {
    return """
      // Check if the document head is available
      // This is important to ensure that we can append styles to the head
      // The menu button is identified by its ID 'menu-toggle'
      // The script creates a style element and appends it to the head of the document
      if (document.head) {
        // Select the menu button by its ID and hide it
        const style = document.createElement('style');
        // This style hides the menu button with ID 'menu-toggle'
        style.innerHTML = 'button#menu-toggle {display: none;}';
        // Append the style element to the head
        // This ensures that the menu button is hidden after the page has loaded
        document.head.appendChild(style);
      }
    """;
  }

  // Disable bounce scroll physics in the Rocketseat app.
  // This script is injected into the WebView to disable bounce scroll physics after the page has loaded.
  String disableBounceScrollPhysics() {
    return """
      // Disable bounce scroll physics in the WebView
      document.body.style.overflow = 'hidden';
      // Prevent overscroll behavior
      document.documentElement.style.overflow = 'hidden';
      // Add a style element to the head to ensure no bounce scroll physics
      if (document.head) {
        const style = document.createElement('style');
        // This style ensures that the WebView does not have bounce scroll physics
        style.innerHTML = `
          html, body {
            overscroll-behavior: none;
            -webkit-overflow-scrolling: auto !important;
            touch-action: none;
          }
        `;
        // Append the style element to the head
        document.head.appendChild(style);
      }
    """;
  }

  // Hide the header in the Rocketseat app.
  // This script is injected into the WebView to hide the header after the page has loaded.
  String hideHeader() {
    // The header is selected using a CSS selector that targets a specific div structure.
    // The style.display property is set to 'none' to hide the header.
    // This is useful for users who do not want to see the header in the Rocketseat app.
    return "document.querySelectorAll('div.px-4.bg-gray-850.border.border-transparent.border-b-gray-700.flex.items-center.justify-between')[0].style.display = 'none';";
  }
}
