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

import 'components/topic_search_field.dart';

class LecturerTopicListPage extends StatefulWidget {
  const LecturerTopicListPage({Key? key}) : super(key: key);

  @override
  State<LecturerTopicListPage> createState() => _LecturerTopicListPageState();
}

class _LecturerTopicListPageState extends State<LecturerTopicListPage> with BasePageState {
  late LecturerTopicListBloc _topicListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _topicListBloc = context.read<LecturerTopicListBloc>();
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
    return BlocListener<LecturerTopicListBloc, LecturerTopicListState>(
      listener: (_, state) {
        if (state is LecturerTopicListFetchedState) {
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
              title: "Topic List",
              pinned: true,
              floating: true,
              actions: const [
                PrimaryBtnMenu(),
              ],
              backgroundColor: theme.primaryColor,
              onBackgroundColor: theme.colorScheme.onPrimary,
              bottom: TopicSearchField(),
            ),
          ],
          body: LecturerTopicListView(),
        ),
      ),
    );
  }
}
