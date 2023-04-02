import 'dart:async';

import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

mixin BasePageState<T extends StatefulWidget> on State<T> {
  bool _isInit = false;

  StreamSubscription<String>? _scannerResultSub;

  bool hasScanningSupport() =>
      false; // set true if you want to support scan by scanner
  String page() => ""; // set current page
  void onScanResult(String result) {} // process scanning result

  void pageInitState() async {} // init once time with getting modal page route

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      _isInit = true;
      pageInitState();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (hasScanningSupport()) {
      Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
        if (!mounted) return;
        _scannerResultSub?.cancel();
        _scannerResultSub?.onData((data) {
          if (!mounted || !NavigationService.instance.isCurrentPage(page())) {
            return;
          }
          onScanResult(data);
        });
      });
    }
  }

  @override
  void dispose() {
    _scannerResultSub?.cancel();
    _scannerResultSub = null;
    super.dispose();
  }
}
