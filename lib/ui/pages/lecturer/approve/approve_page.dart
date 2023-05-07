import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../base/base_page_state.dart';
import 'components/advisor_list_view.dart';
import 'components/critical_list_view.dart';

class LecturerApprovePage extends StatefulWidget {
  @override
  _LecturerApprovePageState createState() => _LecturerApprovePageState();
}

class _LecturerApprovePageState extends State<LecturerApprovePage>
    with BasePageState {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            PrimarySliverAppBar(
              title: "Approve Topic",
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
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              AdvisorTopicListView(),
              CriticalTopicListView(),
            ],
          ),
        ),
      ),
    );
  }
}
