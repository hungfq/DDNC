import 'package:ddnc_new/ui/pages/master/blocs/master_bloc.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_event.dart';
import 'package:ddnc_new/ui/pages/master/blocs/master_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/master_view.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> with WidgetsBindingObserver {
  bool _isInit = false;
  late MasterBloc _masterBloc;

  @override
  void initState() {
    _masterBloc = context.read<MasterBloc>();

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() async {
    if (!mounted) return;
    if (!_isInit) {
      _isInit = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _masterBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MasterBloc, MasterState>(
      listener: _listeners,
      child: const MasterView(),
    );
  }

  void _listeners(BuildContext context, MasterState state) {
    switch (state.runtimeType) {
      case MasterActionState:
        if (state is! MasterActionState) return;
        _handleActionExecuted(state);
        break;

      default:
        break;
    }
  }

  void _handleActionExecuted(MasterActionState state) async {
    switch (state.action) {
      case MasterActionEvent.signOut:
        // ConfirmDialog.show(
        //   context: context,
        //   question: "Are you sure you want to sign out?",
        //   positiveCallback: _masterBloc.signOut,
        // );
        break;
      default:
        break;
    }
  }
//endregion
}
