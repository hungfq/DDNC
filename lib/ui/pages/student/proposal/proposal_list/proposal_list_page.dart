import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/proposal_list_bloc.dart';
import 'blocs/proposal_list_state.dart';
import 'components/proposal_list_view.dart';

class TopicProposalListPage extends StatefulWidget {
  const TopicProposalListPage({Key? key}) : super(key: key);

  @override
  State<TopicProposalListPage> createState() => _TopicProposalListPageState();
}

class _TopicProposalListPageState extends State<TopicProposalListPage>
    with BasePageState {
  late TopicProposalListBloc _topicListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _topicListBloc = context.read<TopicProposalListBloc>();
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
    return BlocListener<TopicProposalListBloc, TopicProposalListState>(
      listener: (_, state) {
        if (state is TopicProposalListFetchedState) {
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
              title: "TopicProposal List",
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
          body: TopicProposalListView(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            NavigationService.instance
                .pushNamed(AppPages.topicProposalDetailPage, args: {
              TopicProposalListView.topic: TopicProposalInfo(
                  0, null, null, null, null, null, null, null, null, []),
              TopicProposalListView.topicAction: "ADD",
            });
          },
        ),
      ),
    );
  }
}
