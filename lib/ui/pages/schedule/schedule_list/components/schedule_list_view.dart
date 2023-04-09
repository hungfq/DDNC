import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import 'package:ddnc_new/ui/pages/schedule/schedule_list/blocs/schedule_list_bloc.dart';
import 'package:ddnc_new/ui/pages/schedule/schedule_list/blocs/schedule_list_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  static const String schedule = "schedule_key";
  static const String scheduleId = "schedule_id_key";
  static const String scheduleAction = "EDIT";

  @override
  State<ScheduleListView> createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> {
  late ScheduleListBloc _scheduleListBloc;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _scheduleListBloc = context.read<ScheduleListBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scrollbar(
        thumbVisibility: true,
        child: BlocConsumer<ScheduleListBloc, ScheduleListState>(
          listener: _handleListeners,
          buildWhen: (_, state) => [
            ScheduleListFetchedState,
            ScheduleListLoadMoreState,
            ScheduleListRefreshedState
          ].contains(state.runtimeType),
          builder: (context, state) {
            var resource = _scheduleListBloc.getListUserResult;
            List<ScheduleInfo> scheduleList = resource.data?.data ?? [];

            return SmartRefresherListView(
              controller: _refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              errorMessage: Helpers.parseResponseError(
                statusCode: resource.statusCode,
                errorMessage: resource.message,
              ),
              child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.marginPaddingSizeXMini,
                  vertical: Dimens.marginPaddingSizeXXMini,
                ),
                itemCount: scheduleList.length,
                itemBuilder: (context, i) {
                  return _UserItem(
                    index: i,
                    schedule: scheduleList[i],
                    onItemClicked: () {
                      _scheduleListBloc.refresh();
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleListeners(BuildContext context, ScheduleListState state) {
    if (state is ScheduleListFetchedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          _refreshController.requestRefresh(needMove: false);
          break;
        case Result.error:
          _refreshController.refreshFailed();
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          _refreshController.refreshCompleted(resetFooterState: true);
          var scheduleList =
              _scheduleListBloc.getListUserResult.data?.data ?? [];
          if (scheduleList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }
      return;
    }

    if (state is ScheduleListRefreshedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          break;
        case Result.error:
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          var scheduleList =
              _scheduleListBloc.getListUserResult.data?.data ?? [];
          if (scheduleList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }

      return;
    }

    if (state is ScheduleListLoadMoreState) {
      var resource = state.resource;
      switch (resource.state) {
        case Result.loading:
          // _refreshController.requestLoading(needMove: false);
          break;
        case Result.error:
          _refreshController.loadFailed();
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          var scheduleList = resource.data?.data ?? [];
          if (scheduleList.isEmpty) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
          break;
        default:
          break;
      }
      return;
    }
  }

  void _onRefresh() async {
    _scheduleListBloc.fetch();
  }

  void _onLoading() async {
    _scheduleListBloc.loadMore();
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    Key? key,
    required this.index,
    required this.schedule,
    required this.onItemClicked,
  }) : super(key: key);

  final int index;
  final ScheduleInfo schedule;
  final Function onItemClicked;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            Dimens.marginPaddingSizeTiny,
            Dimens.marginPaddingSizeMini,
            Dimens.marginPaddingSizeXXTiny,
            Dimens.marginPaddingSizeTiny,
          ),
          margin: const EdgeInsets.only(
            bottom: Dimens.marginPaddingSizeXMini,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimens.mediumComponentRadius)),
            border: Border.all(color: theme.dividerColor),
          ),
          child: ListTile(
            title: Text(schedule.name ?? ""),
            subtitle: Text(schedule.code),
            trailing: Text(
              DateFormat('MMM d, yyyy')
                  .format(DateTime.parse(schedule.deadline ?? "0001-01-01")),
            ),
            onTap: () {
              NavigationService.instance
                  .pushNamed(AppPages.scheduleDetailPage, args: {
                ScheduleListView.schedule: schedule,
                ScheduleListView.scheduleAction: "EDIT",
              });
            },
          ),
        ));
  }
}
