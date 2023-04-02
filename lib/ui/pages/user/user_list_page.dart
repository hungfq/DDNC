import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_state.dart';
import 'package:ddnc_new/ui/pages/user/user_list/components/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _PoListPageState();
}

class _PoListPageState extends State<UserListPage> with BasePageState {
  late UserListBloc _userListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _userListBloc = context.read<UserListBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _userListBloc.fetch();
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
    return BlocListener<UserListBloc, UserListState>(
      listener: (_, state) {
        if (state is UserListFetchedState) {
          _scrollController.animateTo(
            _scrollController.initialScrollOffset,
            duration: const Duration(milliseconds: Constants.animationDuration),
            curve: Constants.defaultCurve,
          );

          return;
        }
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (_, __) => [
            const PrimarySliverAppBar(
              title: "User List",
              pinned: true,
              floating: true,
            ),
          ],
          body: UserListView(),
        ),
      ),
    );
  }
}
