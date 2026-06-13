// Web-only: uses dart:js_interop to call the browser's gtag() function.
import 'dart:js_interop';
import 'package:flutter/material.dart';

/// Calls the browser's gtag() to send a page_view event to GA4.
@JS('gtag')
external void _gtag(String command, String action, JSObject params);

void trackPageView(String path, String title) {
  try {
    _gtag(
      'event',
      'page_view',
      {'page_path': path, 'page_title': title}.jsify()! as JSObject,
    );
  } catch (_) {
    // gtag not available (e.g. during local development)
  }
}

void trackEvent(String eventName, {String? label}) {
  try {
    _gtag(
      'event',
      eventName,
      {'event_label': label ?? eventName}.jsify()! as JSObject,
    );
  } catch (_) {
    // gtag not available (e.g. during local development)
  }
}

/// Fires a GA4 page_view event on every Flutter route change.
///
/// The initial page_view is already fired by the gtag('config', ...) call in
/// index.html, so we skip it here (previousRoute == null means first push).
class MNPAnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) _track(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) _track(previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) _track(newRoute);
  }

  void _track(Route route) {
    final name = route.settings.name;
    if (name != null) {
      trackPageView(name, _titleForRoute(name));
    }
  }

  String _titleForRoute(String route) {
    switch (route) {
      case '/':
        return 'Home';
      case '/about':
        return 'About';
      case '/leadership':
        return 'Leadership';
      case '/services':
        return 'Services';
      case '/gallery':
        return 'Gallery';
      case '/contact':
        return 'Contact';
      default:
        return route;
    }
  }
}
