import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/components/primary_divider_horizontal.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late UserListBloc _userListBloc;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _userListBloc = context.read<UserListBloc>();
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
        child: BlocConsumer<UserListBloc, UserListState>(
          listener: _handleListeners,
          buildWhen: (_, state) => [
            UserListFetchedState,
            UserListLoadMoreState,
            UserListRefreshedState
          ].contains(state.runtimeType),
          builder: (context, state) {
            var resource = _userListBloc.getListUserResult;
            List<UserInfo> userList = resource.data?.data ?? [];

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
                itemCount: userList.length,
                itemBuilder: (context, i) {
                  return _UserItem(
                    index: i,
                    user: userList[i],
                    // onItemClicked: _onItemClicked,
                    // onGrClicked: _onGrClicked,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleListeners(BuildContext context, UserListState state) {
    if (state is UserListFetchedState) {
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
          var userList = _userListBloc.getListUserResult.data?.data ?? [];
          if (userList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }
      return;
    }

    if (state is UserListRefreshedState) {
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
          var userList = _userListBloc.getListUserResult.data?.data ?? [];
          if (userList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }

      return;
    }

    if (state is UserListLoadMoreState) {
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
          var userList = resource.data?.data ?? [];
          if (userList.isEmpty) {
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
    _userListBloc.fetch();
  }

  void _onLoading() async {
    _userListBloc.loadMore();
  }
}

class _UserItem extends StatelessWidget {
  const _UserItem({
    Key? key,
    required this.index,
    required this.user,
    // required this.onItemClicked,
    // required this.onGrClicked,
  }) : super(key: key);

  final int index;
  final UserInfo user;

  // final Function(UserModel) onItemClicked;
  // final Function(UserModel) onGrClicked;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // var onBackgroundColor = _theme.colorScheme.onBackground;
    // var onSurfaceColor = _theme.colorScheme.onSurface;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // onTap: () => onItemClicked.call(po),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          Dimens.marginPaddingSizeXMini,
          Dimens.marginPaddingSizeMini,
          Dimens.marginPaddingSizeXMini,
          Dimens.marginPaddingSizeXMini,
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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  user.name ?? "",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.marginPaddingSizeXXXTiny),
            const PrimaryDividerHorizontal(),
            const SizedBox(height: Dimens.marginPaddingSizeMini),
          ],
        ),
      ),
    );
  }
}
