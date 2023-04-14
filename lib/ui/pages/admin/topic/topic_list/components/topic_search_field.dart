import 'dart:async';

import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/extensions.dart';
import 'package:ddnc_new/ui/components/primary_filled_text_form_field.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_list/blocs/topic_list_bloc.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_list/blocs/topic_list_event.dart';
import 'package:ddnc_new/ui/pages/admin/topic/topic_list/blocs/topic_list_state.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicSearchField extends StatefulWidget with PreferredSizeWidget {
  const TopicSearchField({Key? key}) : super(key: key);

  @override
  State<TopicSearchField> createState() => _TopicSearchFieldState();

  @override
  Size get preferredSize => const Size.fromHeight(
      Dimens.textFieldHeight + Dimens.marginPaddingSizeXXXMini);
}

class _TopicSearchFieldState extends State<TopicSearchField> {
  late ThemeData _theme;
  late TopicListBloc _topicListBloc;

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isShowClearBtn = false;
  Timer? _debounce;

  @override
  void initState() {
    _topicListBloc = context.read<TopicListBloc>();
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

    return BlocListener<TopicListBloc, TopicListState>(
      listener: (_, state) {
        if (state is TopicListDataChangedState &&
            state.event == TopicListDataChangedEvent.keywordChanged) {
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
                hintText: "Code, title or description",
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
      _topicListBloc.search(search);
    });
  }

  void _onSubmitClicked() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _topicListBloc.search(_controller.text);
  }

  void _onClearClicked() {
    _controller.clear();
    _topicListBloc.search("");
    setState(() {
      _isShowClearBtn = false;
    });
  }
}
