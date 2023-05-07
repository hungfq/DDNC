import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_page_state.dart';
import 'blocs/approve_bloc.dart';
import 'components/advisor_list_view.dart';
import 'components/critical_list_view.dart';

class LecturerApprovePage extends StatefulWidget {
  @override
  _LecturerApprovePageState createState() => _LecturerApprovePageState();
}

class _LecturerApprovePageState extends State<LecturerApprovePage>
    with BasePageState {

  final List<String> _advisorTopics = [
    'Topic 122',
    'Topic 2',
    'Topic 3',
    'Topic 4',
    'Topic 5',
  ];

  final List<String> _criticalTopics = [
    'Topic 5',
    'Topic 6',
  ];

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

  void _showModal(BuildContext context, String item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Approve $item'),
              onTap: () {
                setState(() {
                  _advisorTopics.remove(item);
                  _criticalTopics.add(item);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
