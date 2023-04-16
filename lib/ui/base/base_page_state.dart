import 'dart:async';

import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BasePageState<T extends StatefulWidget> on State<T> {
  bool _isInit = false;
  late ThemeData _theme;

  MasterBloc? _masterBloc;
  StreamSubscription<String>? _scannerResultSub;

  bool hasScanningSupport() =>
      false; // set true if you want to support scan by scanner
  String page() => ""; // set current page
  void onScanResult(String result) {} // process scanning result

  void pageInitState() async {} // init once time with getting modal page route

  MasterBloc get masterBloc {
    _masterBloc ??= context.read<MasterBloc>();
    return _masterBloc!;
  }

  ThemeData get theme => _theme;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      _isInit = true;
      _theme = Theme.of(context);
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
