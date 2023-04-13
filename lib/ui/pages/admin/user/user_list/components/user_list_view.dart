import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import '../blocs/user_list_bloc.dart';
import '../blocs/user_list_state.dart';
import '../components/user_show.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  static const String user = "user_key";
  static const String userId = "user_id_key";

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
                    onItemClicked: () {
                      _userListBloc.refresh();
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
    required this.onItemClicked,
  }) : super(key: key);

  final int index;
  final UserInfo user;
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
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture ??
                  'https://res.cloudinary.com/dfkpopvkp/image/upload/v1681039836/user-3814118-3187499_xvjv7p.webp'),
            ),
            title: Text(user.name ?? ""),
            subtitle: Text(user.email ?? ""),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    NavigationService.instance
                        .pushNamed(AppPages.userDetailPage, args: {
                      UserListView.userId: user.id,
                      UserListView.user: user
                    });
                  },
                ),
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
