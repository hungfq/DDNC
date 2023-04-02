import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'indicator_can_refresh.dart';
import 'indicator_load_failed.dart';
import 'indicator_load_no_more.dart';
import 'indicator_refresh_failed.dart';
import 'indicator_refresh_idle.dart';
import 'indicator_refreshing.dart';

class SmartRefresherListView extends StatelessWidget {
  final RefreshController controller;
  final Function() onRefresh;
  final Function() onLoading;
  final String errorMessage;
  final String? noDataMessage;
  final Widget child;

  const SmartRefresherListView(
      {Key? key,
      required this.controller,
      required this.onRefresh,
      required this.onLoading,
      required this.errorMessage,
      this.noDataMessage,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      enablePullUp: true,
      header: CustomHeader(
        builder: (BuildContext context, RefreshStatus? mode) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: Constants.animationDuration),
            switchOutCurve: Constants.defaultCurve,
            switchInCurve: Constants.defaultCurve,
            transitionBuilder: AppTransitions.fadeTransition,
            child: _buildHeader(mode),
          );
        },
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus? mode) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: Constants.animationDuration),
            switchOutCurve: Constants.defaultCurve,
            switchInCurve: Constants.defaultCurve,
            transitionBuilder: AppTransitions.fadeTransition,
            child: _buildFooter(mode),
          );
        },
      ),
      child: child,
    );
  }

  Widget _buildFooter(LoadStatus? mode) {
    switch (mode) {
      case LoadStatus.loading:
        return const Padding(
          padding: EdgeInsets.only(top: Dimens.marginPaddingSizeXMini),
        );
      case LoadStatus.failed:
        return IndicatorLoadFailed(
          errorMessage: errorMessage,
        );
      case LoadStatus.noMore:
        return IndicatorLoadNoMore(
          message: noDataMessage,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHeader(RefreshStatus? mode) {
    switch (mode) {
      case RefreshStatus.idle:
        return const IndicatorRefreshIdle();
      case RefreshStatus.failed:
        return IndicatorRefreshingFailed(
          errorMessage: errorMessage,
        );
      case RefreshStatus.refreshing:
        return const IndicatorRefreshing();
      case RefreshStatus.canRefresh:
        return const IndicatorCanRefresh();
      default:
        return const SizedBox.shrink();
    }
  }
}
