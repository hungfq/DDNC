import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/primary_filled_text_form_field.dart';
import 'package:ddnc_new/ui/components/primary_text_view.dart';
import 'package:ddnc_new/ui/components/system_padding.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import 'package:ddnc_new/ui/resources/app_transitions.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/mark_bloc.dart';
import '../blocs/mark_state.dart';

class LecturerMarkDialog {
  static Future show({
    required BuildContext context,
    required TopicInfo topic,
    required LecturerMarkBloc bloc,
  }) {
    return showGeneralDialog(
      barrierDismissible: false,
      transitionDuration:
          const Duration(milliseconds: Constants.animationDuration),
      transitionBuilder: (_, animation, __, child) =>
          AppTransitions.scaleTransition(child, animation),
      useRootNavigator: false,
      context: context,
      pageBuilder: (_, __, ___) {
        return BlocProvider<LecturerMarkBloc>.value(
          value: bloc,
          child: const _LecturerMarkView(),
        );
      },
      routeSettings: RouteSettings(
        // name: _page,
        arguments: topic,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: false).pop(LecturerMarkDialog);
  }
}

class _LecturerMarkView extends StatefulWidget {
  const _LecturerMarkView({Key? key}) : super(key: key);

  @override
  State<_LecturerMarkView> createState() => _LecturerMarkViewState();
}

class _LecturerMarkViewState extends State<_LecturerMarkView>
    with BasePageState {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _node = FocusNode();

  late LecturerMarkBloc _lecturerMarkBloc;
  late TopicInfo _topic;

  @override
  void pageInitState() {
    _lecturerMarkBloc = context.read<LecturerMarkBloc>();
    _topic = ModalRoute.of(context)!.settings.arguments as TopicInfo;
    super.pageInitState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LecturerMarkBloc, LecturerMarkState>(
      listener: _handleListeners,
      child: SystemPadding(
        child: Center(
          child: Wrap(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(Dimens.marginPaddingSizeXXMini),
                decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(Dimens.largeComponentRadius)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                              Dimens.marginPaddingSizeMini,
                              Dimens.marginPaddingSizeMini,
                              Dimens.marginPaddingSizeMini,
                              Dimens.marginPaddingSizeMini,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimens.largeComponentRadius),
                                bottomRight: Radius.circular(
                                    Dimens.mediumComponentRadius),
                              ),
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: Dimens.iconSize,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                  height: Dimens.marginPaddingSizeXXMini),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    Dimens.marginPaddingSizeXXMini,
                                    0,
                                    Dimens.marginPaddingSizeXXMini,
                                    Dimens.marginPaddingSizeXXMini),
                                child: PrimaryTextView(
                                  "Enter your mark",
                                  style: theme.textTheme.bodyLarge!
                                      .apply(color: theme.colorScheme.onSurface),
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: Dimens.marginPaddingSizeSmall),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.marginPaddingSizeXXMini,
                        Dimens.marginPaddingSizeXMini,
                        Dimens.marginPaddingSizeXXMini,
                        Dimens.marginPaddingSizeXXXMini,
                      ),
                      child: PrimaryFilledTextFormField(
                        labelText: "Mark",
                        textEditingController: _controller,
                        currentFocus: _node,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    _OptionItem(
                      title: "Save",
                      onItemClicked: _onSaveClicked,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveClicked() {
    FocusScope.of(context).unfocus();

    _lecturerMarkBloc.mark(_topic.id, _controller.text);
  }

  void _handleListeners(BuildContext context, LecturerMarkState state) {
    if (state is LecturerMarkedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          LoadingDialog.show(context);
          break;
        case Result.error:
          LoadingDialog.hide(context);

          Helpers.showErrorDialog(context: context, resource: resource);
          break;
        case Result.success:
          LoadingDialog.hide(context);
          // Navigator.of(context).pop(true);

          SuccessDialog.show(
              context: context,
              msg: resource.data ?? "",
              // callback: () {
              //   Navigator.of(context).pop(true);
              // }
              );
          break;
      }

      return;
    }
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({
    Key? key,
    required this.title,
    required this.onItemClicked,
  }) : super(key: key);

  final String title;
  final Function() onItemClicked;

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onItemClicked.call(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.marginPaddingSizeXXMini,
          horizontal: Dimens.marginPaddingSizeXXMini,
        ),
        alignment: Alignment.center,
        child: PrimaryTextView(
          title,
          style: _theme.textTheme.labelLarge!.apply(
            color: _theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
