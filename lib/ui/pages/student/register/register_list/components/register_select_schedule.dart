import 'dart:async';

import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/extensions.dart';
import 'package:ddnc_new/ui/components/primary_filled_text_form_field.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/blocs/register_list_bloc.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/blocs/register_list_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommitteeSearchField extends StatefulWidget with PreferredSizeWidget {
  const CommitteeSearchField({Key? key}) : super(key: key);

  @override
  State<CommitteeSearchField> createState() => _CommitteeSearchFieldState();

  @override
  Size get preferredSize => const Size.fromHeight(
      Dimens.textFieldHeight + Dimens.marginPaddingSizeXXXMini);
}

class _CommitteeSearchFieldState extends State<CommitteeSearchField> {
  late ThemeData _theme;
  late RegisterListBloc _committeeListBloc;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isShowClearBtn = false;
  Timer? _debounce;

  @override
  void initState() {
    _committeeListBloc = context.read<RegisterListBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    return BlocListener<RegisterListBloc, RegisterListState>(
      listener: (_, state) {
        if (state is CommitteeListDataChangedState &&
            state.event == CommitteeListDataChangedEvent.keywordChanged) {
          _controller.setText(state.data);
          _onSearchChanged(state.data);
          _onSubmitClicked();
          return;
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          Dimens.marginPaddingSizeXMini,
          0,
          Dimens.marginPaddingSizeXMini,
          Dimens.marginPaddingSizeXMini,
        ),
        decoration: BoxDecoration(
          color: _theme.colorScheme.surface,
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PrimaryFilledTextFormField(
                textEditingController: _controller,
                currentFocus: _focusNode,
                onSubmitCallback: _onSubmitClicked,
                prefixIcon: CupertinoIcons.search,
                hintText: "Code or name",
                textInputAction: TextInputAction.search,
                suffixIcon:
                    _isShowClearBtn ? CupertinoIcons.xmark_circle_fill : null,
                onChanged: _onSearchChanged,
                onEndIconPress: _onClearClicked,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchChanged(String search) {
    bool isShow = search.isNotEmpty;

    if (_isShowClearBtn != isShow) {
      setState(() {
        _isShowClearBtn = isShow;
      });
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Constants.filterDelayTime, () {
      _committeeListBloc.search(search);
    });
  }

  void _onSubmitClicked() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _committeeListBloc.search(_controller.text);
  }

  void _onClearClicked() {
    _controller.clear();
    _committeeListBloc.search("");
    setState(() {
      _isShowClearBtn = false;
    });
  }
}
