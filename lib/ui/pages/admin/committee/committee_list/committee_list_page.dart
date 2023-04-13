import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/committee_list_bloc.dart';
import 'blocs/committee_list_state.dart';
import 'components/committee_list_view.dart';

class CommitteeListPage extends StatefulWidget {
  const CommitteeListPage({Key? key}) : super(key: key);

  @override
  State<CommitteeListPage> createState() => _CommitteeListPageState();
}

class _CommitteeListPageState extends State<CommitteeListPage>
    with BasePageState {
  late CommitteeListBloc _committeeListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _committeeListBloc = context.read<CommitteeListBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _committeeListBloc.fetch();
    });
    super.initState();
  }

  @override
  String page() => AppPages.userListPage;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommitteeListBloc, CommitteeListState>(
      listener: (_, state) {
        if (state is CommitteeListFetchedState) {
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
            PrimarySliverAppBar(
              title: "Committee List",
              pinned: true,
              floating: true,
              actions: [
                PrimaryBtnMenu(),
              ],
            ),
          ],
          body: CommitteeListView(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            NavigationService.instance
                .pushNamed(AppPages.committeeDetailPage, args: {
              CommitteeListView.committee:
                  CommitteeInfo(0, "", null, null, null, null, []),
              CommitteeListView.committeeAction: "ADD",
            });
          },
        ),
      ),
    );
  }
}
