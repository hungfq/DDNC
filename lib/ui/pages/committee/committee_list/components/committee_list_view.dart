import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import 'package:ddnc_new/ui/pages/committee/committee_list/blocs/committee_list_bloc.dart';
import 'package:ddnc_new/ui/pages/committee/committee_list/blocs/committee_list_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommitteeListView extends StatefulWidget {
  const CommitteeListView({Key? key}) : super(key: key);

  static const String committee = "committee_key";
  static const String committeeId = "committee_id_key";
  static const String committeeAction = "EDIT";

  @override
  State<CommitteeListView> createState() => _CommitteeListViewState();
}

class _CommitteeListViewState extends State<CommitteeListView> {
  late CommitteeListBloc _committeeListBloc;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _committeeListBloc = context.read<CommitteeListBloc>();
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
        child: BlocConsumer<CommitteeListBloc, CommitteeListState>(
          listener: _handleListeners,
          buildWhen: (_, state) => [
            CommitteeListFetchedState,
            CommitteeListLoadMoreState,
            CommitteeListRefreshedState
          ].contains(state.runtimeType),
          builder: (context, state) {
            var resource = _committeeListBloc.getListUserResult;
            List<CommitteeInfo> committeeList = resource.data?.data ?? [];

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
                itemCount: committeeList.length,
                itemBuilder: (context, i) {
                  return _UserItem(
                    index: i,
                    committee: committeeList[i],
                    onItemClicked: () {
                      _committeeListBloc.refresh();
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

  void _handleListeners(BuildContext context, CommitteeListState state) {
    if (state is CommitteeListFetchedState) {
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
          var committeeList =
              _committeeListBloc.getListUserResult.data?.data ?? [];
          if (committeeList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }
      return;
    }

    if (state is CommitteeListRefreshedState) {
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
          var committeeList =
              _committeeListBloc.getListUserResult.data?.data ?? [];
          if (committeeList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }

      return;
    }

    if (state is CommitteeListLoadMoreState) {
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
          var committeeList = resource.data?.data ?? [];
          if (committeeList.isEmpty) {
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
    _committeeListBloc.fetch();
  }

  void _onLoading() async {
    _committeeListBloc.loadMore();
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    Key? key,
    required this.index,
    required this.committee,
    required this.onItemClicked,
  }) : super(key: key);

  final int index;
  final CommitteeInfo committee;
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
            title: Text(committee.name ?? ""),
            subtitle: Text(committee.code),
            onTap: () {
              NavigationService.instance
                  .pushNamed(AppPages.committeeDetailPage, args: {
                CommitteeListView.committee: committee,
                CommitteeListView.committeeAction: "EDIT",
              });
            },
          ),
        ));
  }
}
