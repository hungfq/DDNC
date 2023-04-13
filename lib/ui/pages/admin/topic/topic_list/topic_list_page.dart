import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'blocs/topic_list_bloc.dart';
import 'blocs/topic_list_state.dart';
import 'components/topic_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicListPage extends StatefulWidget {
  const TopicListPage({Key? key}) : super(key: key);

  @override
  State<TopicListPage> createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> with BasePageState {
  late TopicListBloc _topicListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _topicListBloc = context.read<TopicListBloc>();
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
    return BlocListener<TopicListBloc, TopicListState>(
      listener: (_, state) {
        if (state is TopicListFetchedState) {
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
              title: "Topic List",
              pinned: true,
              floating: true,
              actions: [
                PrimaryBtnMenu(),
              ],
            ),
          ],
          body: TopicListView(),
        ),
      ),
    );
  }
}
