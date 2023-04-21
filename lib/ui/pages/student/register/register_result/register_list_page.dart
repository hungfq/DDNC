import 'package:ddnc_new/commons/app_page.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_btn_menu.dart';
import 'package:ddnc_new/ui/components/primary_sliver_app_bar.dart';
import 'package:ddnc_new/ui/pages/student/register/register_result/components/register_result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register_list/components/register_list_view.dart';
import 'blocs/register_result_bloc.dart';
import 'blocs/register_result_state.dart';

class RegisterResultPage extends StatefulWidget {
  const RegisterResultPage({Key? key}) : super(key: key);

  @override
  State<RegisterResultPage> createState() => _RegisterResultPageState();
}

class _RegisterResultPageState extends State<RegisterResultPage>
    with BasePageState {
  late RegisterResultBloc _registerResultBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _registerResultBloc = context.read<RegisterResultBloc>();
    Future.delayed(const Duration(milliseconds: Constants.delayTime), () {
      if (!mounted) return;

      _registerResultBloc.fetch();
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
    return BlocListener<RegisterResultBloc, RegisterResultState>(
      listener: (_, state) {
        if (state is RegisterTopicListFetchedState) {
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
              title: "Register Result",
              pinned: true,
              floating: true,
              actions: const [
                PrimaryBtnMenu(),
              ],
              backgroundColor: theme.primaryColor,
              onBackgroundColor: theme.colorScheme.onPrimary,
              // bottom: RegisterSearchField(),
            ),
          ],
          body: RegisterResultView(),
        ),
      ),
    );
  }
}
