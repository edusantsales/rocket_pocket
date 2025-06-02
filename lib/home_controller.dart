import 'package:flutter/material.dart';

class HomeController {
  final String baseURL = const String.fromEnvironment('BASE_URL');
  final ValueNotifier<int> loadingProgress = ValueNotifier<int>(0);

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
