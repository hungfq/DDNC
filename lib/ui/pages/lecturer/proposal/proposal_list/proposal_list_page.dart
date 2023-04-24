import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/proposal_list_bloc.dart';
import 'blocs/proposal_list_state.dart';
import 'components/proposal_list_view.dart';

class ApproveProposalListPage extends StatefulWidget {
  const ApproveProposalListPage({Key? key}) : super(key: key);

  @override
  State<ApproveProposalListPage> createState() => _ApproveProposalListPageState();
}

class _ApproveProposalListPageState extends State<ApproveProposalListPage>
    with BasePageState {
  late ApproveProposalListBloc _topicListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _topicListBloc = context.read<ApproveProposalListBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _topicListBloc.fetch();
    });
    super.initState();
  }

  @override
  String page() => AppPages.topicListPage;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApproveProposalListBloc, ApproveProposalListState>(
      listener: (_, state) {
        if (state is ApproveProposalListFetchedState) {
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
              title: "Approve Proposal List",
              pinned: true,
              floating: true,
              actions: const [
                PrimaryBtnMenu(),
              ],
              backgroundColor: theme.primaryColor,
              onBackgroundColor: theme.colorScheme.onPrimary,
              // bottom: TopicProposalSearchField(),
            ),
          ],
          body: ApproveProposalListView(),
        ),
      ),
    );
  }
}
