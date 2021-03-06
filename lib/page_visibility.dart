import 'package:flutter/material.dart';
import 'package:flutter_boost/logger.dart';

///observer for all pages visibility
abstract class GlobalPageVisibilityObserver {
  void onPageCreate(Route<dynamic> route);

  void onPageShow(Route<dynamic> route);

  void onPageHide(Route<dynamic> route);

  void onPageDestroy(Route<dynamic> route);
}

///observer for single page visibility
abstract class PageVisibilityObserver {
  void onPageCreate();

  void onPageShow();

  void onPageHide();

  void onPageDestroy();
}

class PageVisibilityBinding {
  PageVisibilityBinding._();

  static final PageVisibilityBinding instance = PageVisibilityBinding._();

  ///listeners for single page event
  final Map<Route<dynamic>, Set<PageVisibilityObserver>> _listeners =
      <Route<dynamic>, Set<PageVisibilityObserver>>{};

  ///listeners for all pages event
  final Set<GlobalPageVisibilityObserver> _globalListeners =
      <GlobalPageVisibilityObserver>{};

  /// Registers the given object and route as a binding observer.
  void addObserver(PageVisibilityObserver observer, Route<dynamic> route) {
    assert(observer != null);
    assert(route != null);
    final Set<PageVisibilityObserver> observers =
        _listeners.putIfAbsent(route, () => <PageVisibilityObserver>{});
    observers.add(observer);
    Logger.log(
        'page_visibility, #addObserver, $observers, ${route.settings.name}');
  }

  /// Unregisters the given observer.
  void removeObserver(PageVisibilityObserver observer) {
    assert(observer != null);
    for (final Route<dynamic> route in _listeners.keys) {
      final Set<PageVisibilityObserver> observers = _listeners[route];
      observers?.remove(observer);
    }
    Logger.log('page_visibility, #removeObserver, $observer');
  }

  ///Register [observer] to [_globalListeners] set
  void addGlobalObserver(GlobalPageVisibilityObserver observer) {
    assert(observer != null);
    _globalListeners.add(observer);
    Logger.log('page_visibility, #addGlobalObserver, $observer');
  }

  ///Register [observer] from [_globalListeners] set
  void removeGlobalObserver(GlobalPageVisibilityObserver observer) {
    assert(observer != null);
    _globalListeners.remove(observer);
    Logger.log('page_visibility, #removeGlobalObserver, $observer');
  }

  void dispatchPageCreateEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }

    final List<PageVisibilityObserver> observers = _listeners[route]?.toList();
    if (observers != null) {
      for (PageVisibilityObserver observer in observers) {
        try {
          observer.onPageCreate();
        } catch (e) {
          Logger.log(e);
        }
      }
    }
    Logger.log(
        'page_visibility, #dispatchPageShowEvent, ${route.settings.name}');

    dispatchGlobalPageCreateEvent(route);
  }

  void dispatchPageShowEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }

    final List<PageVisibilityObserver> observers = _listeners[route]?.toList();
    if (observers != null) {
      for (PageVisibilityObserver observer in observers) {
        try {
          observer.onPageShow();
        } catch (e) {
          Logger.log(e);
        }
      }
    }
    Logger.log(
        'page_visibility, #dispatchPageShowEvent, ${route.settings.name}');

    dispatchGlobalPageShowEvent(route);
  }

  void dispatchPageHideEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }

    final List<PageVisibilityObserver> observers = _listeners[route]?.toList();
    if (observers != null) {
      for (PageVisibilityObserver observer in observers) {
        try {
          observer.onPageHide();
        } catch (e) {
          Logger.log(e);
        }
      }
    }
    Logger.log(
        'page_visibility, #dispatchPageHideEvent, ${route.settings.name}');

    dispatchGlobalPageHideEvent(route);
  }

  void dispatchPageDestroyEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }

    final List<PageVisibilityObserver> observers = _listeners[route]?.toList();
    if (observers != null) {
      for (PageVisibilityObserver observer in observers) {
        try {
          observer.onPageDestroy();
        } catch (e) {
          Logger.log(e);
        }
      }
    }

    Logger.log(
        'page_visibility, #dispatchPageDestroyEvent, ${route.settings.name}');

    dispatchGlobalPageDestroyEvent(route);
  }

  void dispatchGlobalPageCreateEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }
    final List<GlobalPageVisibilityObserver> globalObserversList =
        _globalListeners.toList();

    for (GlobalPageVisibilityObserver observer in globalObserversList) {
      observer.onPageCreate(route);
    }

    Logger.log(
        'page_visibility, #dispatchGlobalPageCreateEvent, ${route.settings.name}');
  }

  void dispatchGlobalPageShowEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }
    final List<GlobalPageVisibilityObserver> globalObserversList =
        _globalListeners.toList();

    for (GlobalPageVisibilityObserver observer in globalObserversList) {
      observer.onPageShow(route);
    }

    Logger.log(
        'page_visibility, #dispatchGlobalPageShowEvent, ${route.settings.name}');
  }

  void dispatchGlobalPageHideEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }
    final List<GlobalPageVisibilityObserver> globalObserversList =
        _globalListeners.toList();

    for (GlobalPageVisibilityObserver observer in globalObserversList) {
      observer.onPageHide(route);
    }

    Logger.log(
        'page_visibility, #dispatchGlobalPageHideEvent, ${route.settings.name}');
  }

  void dispatchGlobalPageDestroyEvent(Route<dynamic> route) {
    if (route == null) {
      return;
    }
    final List<GlobalPageVisibilityObserver> globalObserversList =
        _globalListeners.toList();

    for (GlobalPageVisibilityObserver observer in globalObserversList) {
      observer.onPageDestroy(route);
    }

    Logger.log(
        'page_visibility, #dispatchGlobalPageDestroyEvent, ${route.settings.name}');
  }
}
