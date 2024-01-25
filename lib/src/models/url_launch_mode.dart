enum WebonKitDartUrlLaunchMode {
  /// Leaves the decision of how to launch the URL to the platform
  /// implementation.
  platformDefault,

  /// Loads the URL in an in-app web view (e.g., Android WebView).
  inAppWebView,

  /// Loads the URL in an in-app web view (e.g., Android Custom Tabs, SFSafariViewController).
  inAppBrowserView,

  /// Passes the URL to the OS to be handled by another application.
  externalApplication,

  /// Passes the URL to the OS to be handled by another non-browser application.
  externalNonBrowserApplication,
}
