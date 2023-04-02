import 'dart:developer';

import 'package:ddnc_new/models/page_info.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef OnRouteChange<R extends Route<dynamic>> = void Function(
    R route, R previousRoute);

class AppNavigatorObserver<R extends Route<dynamic>> extends NavigatorObserver {
  AppNavigatorObserver({
    this.enableLogger = true,
    this.onPush,
    this.onPop,
    this.onReplace,
    this.onRemove,
    this.noNavigator = false,
  }) : _stack = [];

  final List<R> _stack;
  final bool enableLogger;

  final OnRouteChange<R>? onPush;
  final OnRouteChange<R>? onPop;
  final OnRouteChange<R>? onReplace;
  final OnRouteChange<R>? onRemove;
  final bool noNavigator;

  //create clone list from stack
  List<R> get stack => List<R>.from(_stack);

  final BehaviorSubject<PageInfo?> _pageInfoController = BehaviorSubject<PageInfo?>();

  Stream<PageInfo?> get pageInfoStream => _pageInfoController.stream;

  BehaviorSubject<PageInfo?> get pageInfoController => _pageInfoController;

  PageInfo? get currentRoute => _pageInfoController.valueOrNull;

  set currentRoute(PageInfo? currentRoute) {
    _pageInfoController.sink.add(currentRoute);
  }

  @override
  NavigatorState? get navigator => noNavigator ? null : super.navigator;

  @override
  void didPush(Route route, Route? previousRoute) {
    _stack.add(route as R);
    _logStack();
    if (onPush != null && previousRoute != null) {
      onPush!(route, previousRoute as R);
    }
    _changeRoute(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _log('{didPop} \n route: $route \n previousRoute: $previousRoute');
    _stack.remove(route);
    _logStack();
    if (onPop != null) {
      onPop!(route as R, previousRoute as R);
    }
    if (previousRoute != null) {
      _changeRoute(previousRoute);
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _log('{didReplace} \n newRoute: $newRoute \n oldRoute: $oldRoute');
    if (_stack.contains(oldRoute as R)) {
      final oldItemIndex = _stack.indexOf(oldRoute);
      _stack[oldItemIndex] = newRoute as R;
    }
    _logStack();
    if (onReplace != null) {
      onReplace!(newRoute as R, oldRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _log('{didRemove} \n route: $route \n previousRoute: $previousRoute');
    stack.remove(route);
    _logStack();
    if (onRemove != null) {
      onRemove!(route as R, previousRoute as R);
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    _log(
        '{didStartUserGesture} \n route: $route \n previousRoute: $previousRoute');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    _log('{didStopUserGesture}');
    super.didStopUserGesture();
  }

  void _logStack() {
    final mappedStack =
        _stack.map((Route route) => route.settings.name).toList();

    _log('Navigator stack: $mappedStack');
  }

  void _log(String content) {
    if (enableLogger) {
      log(content);
    }
  }

  void _changeRoute(Route pageRoute) {
    if (pageRoute is PageRoute) {
      _pageInfoController.sink.add(PageInfo()
        ..param = pageRoute.settings.name
        ..route = pageRoute.settings.name
        ..isFirst = pageRoute.isFirst);
    }
  }
}
