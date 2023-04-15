import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/modules/navigation/navigation_service.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/pages/admin/schedule/schedule_list/components/schedule_search_field.dart';
import 'blocs/schedule_list_bloc.dart';
import 'blocs/schedule_list_state.dart';
import 'components/schedule_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage>
    with BasePageState {
  late ScheduleListBloc _scheduleListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scheduleListBloc = context.read<ScheduleListBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _scheduleListBloc.fetch();
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
    return BlocListener<ScheduleListBloc, ScheduleListState>(
      listener: (_, state) {
        if (state is ScheduleListFetchedState) {
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
              title: "Schedule List",
              pinned: true,
              floating: true,
              actions: [
                PrimaryBtnMenu(),
              ],
              bottom: ScheduleSearchField(),
            ),
          ],
          body: ScheduleListView(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            NavigationService.instance
                .pushNamed(AppPages.scheduleDetailPage, args: {
              ScheduleListView.schedule: ScheduleInfo(0, "", null, null, null,
                  null, null, null, null, null, null, null, []),
              ScheduleListView.scheduleAction: "ADD",
            });
          },
        ),
      ),
    );
  }
}
