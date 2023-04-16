import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardInitState());

  ValueNotifier<bool> hideFooter = ValueNotifier(true);

  void dispose() {
    hideFooter.dispose();
  }
}
