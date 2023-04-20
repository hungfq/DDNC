import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/components/dropdown_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/register_list_bloc.dart';
import 'blocs/register_list_state.dart';
import 'components/register_list_view.dart';

class RegisterListPage extends StatefulWidget {
  const RegisterListPage({Key? key}) : super(key: key);

  @override
  State<RegisterListPage> createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage>
    with BasePageState {
  late RegisterListBloc _registerListBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _registerListBloc = context.read<RegisterListBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

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
    return BlocListener<RegisterListBloc, RegisterListState>(
      listener: (_, state) {
        if (state is RegisterScheduleFetchedState) {
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
              title: "Register List",
              pinned: true,
              floating: true,
              actions: const [
                PrimaryBtnMenu(),
              ],
              backgroundColor: theme.primaryColor,
              onBackgroundColor: theme.colorScheme.onPrimary,
              // bottom: RegisterSearchField(),
              bottom: DropdownSchedule(),
            ),
          ],
          body: RegisterListView(),
        ),
      ),
    );
  }
}
