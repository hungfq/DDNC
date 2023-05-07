import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../base/base_page_state.dart';
import 'components/topic_list_view.dart';

class LecturerMarkPage extends StatefulWidget {
  @override
  _LecturerMarkPageState createState() => _LecturerMarkPageState();
}

class _LecturerMarkPageState extends State<LecturerMarkPage>
    with BasePageState {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            PrimarySliverAppBar(
              title: "Mark",
              pinned: true,
              floating: true,
              actions: const [
                PrimaryBtnMenu(),
              ],
              backgroundColor: theme.primaryColor,
              onBackgroundColor: theme.colorScheme.onPrimary,
              bottom: TabBar(
                labelColor: Colors.white,
                tabs: [
                  Tab(text: 'Advisor'),
                  Tab(text: 'Critical'),
                  Tab(text: 'President'),
                  Tab(text: 'Secretary'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              MarkTopicListView(TYPE: 1),
              MarkTopicListView(TYPE: 2),
              MarkTopicListView(TYPE: 3),
              MarkTopicListView(TYPE: 4),
            ],
          ),
        ),
      ),
    );
  }
}
