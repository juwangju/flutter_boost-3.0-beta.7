import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_boost/boost_navigator.dart';
import 'package:flutter_boost/flutter_boost_app.dart';

class BoostContainer extends StatefulWidget {
  BoostContainer({LocalKey key, this.routeFactory, this.pageInfo})
      : super(key: key) {
    pages.add(BoostPage.create(pageInfo, routeFactory));
  }

  static BoostContainer of(BuildContext context) {
    final BoostContainer container =
        context.findAncestorWidgetOfExactType<BoostContainer>();
    return container;
  }

  final FlutterBoostRouteFactory routeFactory;
  final PageInfo pageInfo;

  final List<BoostPage<dynamic>> _pages = <BoostPage<dynamic>>[];

  List<BoostPage<dynamic>> get pages => _pages;

  BoostPage<dynamic> get topPage => pages.last;

  int get size => pages.length;

  NavigatorState get navigator => _navKey.currentState;
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  State<StatefulWidget> createState() => BoostContainerState();
}

class BoostContainerState extends State<BoostContainer> {
  void _updatePagesList() {
    widget.pages.removeLast();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget._navKey,
      pages: List<Page<dynamic>>.of(widget._pages),
      onPopPage: (Route<dynamic> route, dynamic result) {
        if (route.didPop(result)) {
          _updatePagesList();
          return true;
        }
        return false;
      },
      observers: <NavigatorObserver>[
        BoostNavigatorObserver(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
