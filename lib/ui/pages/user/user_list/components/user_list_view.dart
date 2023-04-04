import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_state.dart';
import 'package:ddnc_new/ui/pages/user/user_list/components/user_edit.dart';
import 'package:ddnc_new/ui/pages/user/user_list/components/user_show.dart';
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

    if (state is UserUpdatedState) {
      var resource = state.resource;
      switch (resource.state) {
        case Result.loading:
          break;
        case Result.error:
          break;
        case Result.success:
          _userListBloc.fetch();
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
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(user.name ?? ""),
            subtitle: Text(user.email ?? ""),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    dynamic userUpdated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEditPage(user: user),
                      ),
                    );

                    print(userUpdated);
                    // _onEditSaveClick(userUpdated);
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.delete),
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: Text("Confirm Delete"),
                //           content: Text(
                //               "Are you sure you want to delete this user?"),
                //           actions: [
                //             TextButton(
                //               child: Text("Cancel"),
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //             ),
                //             TextButton(
                //               child: Text("Delete"),
                //               onPressed: () {
                //                 // setState(() {
                //                 //   widget.users.removeAt(index);
                //                 // });
                //                 Navigator.of(context).pop();
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserShowPage(user: user),
                ),
              );
            },
          ),
        ));
  }
}
