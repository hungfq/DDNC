import 'package:ddnc_new/api/response/list_stats_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'blocs/stats_bloc.dart';
import 'blocs/stats_state.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with BasePageState {
  late StatsBloc _statsBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _statsBloc = context.read<StatsBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _statsBloc.fetch();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatsBloc, StatsState>(
        listener: (_, state) {
          if (state is StatsFetchedState) {
            var resource = state.resource;

            switch (resource.state) {
              case Result.loading:
                // _refreshController.requestRefresh(needMove: false);
                break;
              case Result.error:
                // _refreshController.refreshFailed();
                // int statusCode = resource.statusCode!;
                // if (statusCode == Constants.invalidTokenStatusCode) {
                //   Helpers.reSignIn(context);
                // }
                break;
              case Result.success:
                // _refreshController.refreshCompleted(resetFooterState: true);
                var scheduleList =
                    _statsBloc.getListUserResult.data?.advisorStats ?? [];
                // if (scheduleList.isEmpty) {
                //   _refreshController.loadNoData();
                // }
                break;
              default:
                break;
            }
            return;
          }
          if (state is StatsState) {
            _scrollController.animateTo(
              _scrollController.initialScrollOffset,
              duration:
                  const Duration(milliseconds: Constants.animationDuration),
              curve: Constants.defaultCurve,
            );

            return;
          }
        },
        buildWhen: (_, state) => [
              StatsFetchedState,
            ].contains(state.runtimeType),
        builder: (context, state) {
          var resource = _statsBloc.getListUserResult;
          List<StatsInfo> data = resource.data?.advisorStats ?? [];
          List<StatsInfo> dataGender = resource.data?.genderStats ?? [];

          return DefaultTabController(
            length: 2,
            child: Scaffold(
                body: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                PrimarySliverAppBar(
                  title: "Statistics",
                  pinned: true,
                  floating: true,
                  actions: const [
                    PrimaryBtnMenu(),
                  ],
                  backgroundColor: theme.primaryColor,
                  onBackgroundColor: theme.colorScheme.onPrimary,
                  bottom: TabBar(
                    labelColor: Colors.white,
                    tabs: [
                      Tab(text: 'Advisor'),
                      Tab(text: 'Gender'),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  SfCartesianChart(
                    title: ChartTitle(text: 'Advisor Topic Count'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<StatsInfo, String>>[
                      BarSeries<StatsInfo, String>(
                        dataSource: data,
                        xValueMapper: (StatsInfo data, _) => data.name,
                        yValueMapper: (StatsInfo data, _) => data.count,
                        name: 'Advisor Count',
                      )
                    ],
                  ),
                  SfCircularChart(
                    legend: Legend(isVisible: true),
                    series: <CircularSeries>[
                      PieSeries<StatsInfo, String>(
                        dataSource: dataGender,
                        xValueMapper: (StatsInfo data, _) => data.name,
                        yValueMapper: (StatsInfo data, _) => data.count,
                        name: 'Gender',
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            labelIntersectAction: LabelIntersectAction.none,
                            // format: '{point.y}%'),
                            textStyle: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
