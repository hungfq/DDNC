import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/components/smart_refresher_listview.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import 'package:ddnc_new/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/mark_bloc.dart';
import '../blocs/mark_state.dart';
import 'mark_dialog.dart';
import 'topic_show.dart';

class MarkTopicListView extends StatefulWidget {
  MarkTopicListView({Key? key, required int TYPE})
      : TYPE = TYPE,
        super(key: key);

  static const String topic = "topic_key";
  int TYPE;

  @override
  State<MarkTopicListView> createState() => _MarkTopicListViewState();
}

class _MarkTopicListViewState extends State<MarkTopicListView> {
  late LecturerMarkBloc _markBloc;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _markBloc = context.read<LecturerMarkBloc>();
    _markBloc.TYPE = widget.TYPE;
    _markBloc.fetch();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      // child: Scrollbar(
      //   thumbVisibility: true,
      child: BlocConsumer<LecturerMarkBloc, LecturerMarkState>(
        listener: _handleListeners,
        buildWhen: (_, state) => [
          LecturerTopicFetchedState,
          LecturerTopicLoadMoreState,
          LecturerTopicRefreshedState,
          LecturerMarkedState,
        ].contains(state.runtimeType),
        builder: (context, state) {
          var resource = _markBloc.getTopicResult;
          List<TopicInfo> topicList = resource.data?.data ?? [];

          return SmartRefresherListView(
            controller: _refreshController,
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            errorMessage: Helpers.parseResponseError(
              statusCode: resource.statusCode,
              errorMessage: resource.message,
            ),
            child: ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.marginPaddingSizeXMini,
                vertical: Dimens.marginPaddingSizeXXMini,
              ),
              itemCount: topicList.length,
              itemBuilder: (context, i) {
                return _TopicItem(
                  index: i,
                  topic: topicList[i],
                  onItemApproved: _handleApprove,
                );
              },
            ),
          );
        },
      ),
      // ),
    );
  }

  void _handleListeners(BuildContext context, LecturerMarkState state) {
    if (state is LecturerTopicFetchedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          _refreshController.requestRefresh(needMove: false);
          break;
        case Result.error:
          _refreshController.refreshFailed();
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          _refreshController.refreshCompleted(resetFooterState: true);
          var userList = _markBloc.getTopicResult.data?.data ?? [];
          if (userList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }
      return;
    }

    if (state is LecturerTopicRefreshedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          break;
        case Result.error:
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          var userList = _markBloc.getTopicResult.data?.data ?? [];
          if (userList.isEmpty) {
            _refreshController.loadNoData();
          }
          break;
        default:
          break;
      }

      return;
    }

    if (state is LecturerTopicLoadMoreState) {
      var resource = state.resource;
      switch (resource.state) {
        case Result.loading:
          // _refreshController.requestLoading(needMove: false);
          break;
        case Result.error:
          _refreshController.loadFailed();
          // int statusCode = resource.statusCode!;
          // if (statusCode == Constants.invalidTokenStatusCode) {
          //   Helpers.reSignIn(context);
          // }
          break;
        case Result.success:
          var userList = resource.data?.data ?? [];
          if (userList.isEmpty) {
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
          break;
        default:
          break;
      }
      return;
    }

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
          // _markBloc.fetch();
          LoadingDialog.hide(context);

          SuccessDialog.show(
            context: context,
            msg: resource.data ?? "",
          );
          break;
        default:
          break;
      }
      return;
    }
  }

  void _onRefresh() async {
    _markBloc.fetch();
  }

  void _onLoading() async {
    _markBloc.loadMore();
  }

  void _handleApprove(TopicInfo topic) {
    LecturerMarkDialog.show(
      context: context,
      topic: topic,
      bloc: _markBloc,
    ).then((result) {
      if (result == null) return;

      _markBloc.fetch();
    });
  }
}

class _TopicItem extends StatelessWidget {
  const _TopicItem({
    Key? key,
    required this.index,
    required this.topic,
    required this.onItemApproved,
  }) : super(key: key);

  final int index;
  final TopicInfo topic;

  final Function(TopicInfo) onItemApproved;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // var onBackgroundColor = _theme.colorScheme.onBackground;
    // var onSurfaceColor = _theme.colorScheme.onSurface;

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        // onTap: () => onItemClicked.call(po),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            Dimens.marginPaddingSizeTiny,
            Dimens.marginPaddingSizeMini,
            Dimens.marginPaddingSizeXXTiny,
            Dimens.marginPaddingSizeTiny,
          ),
          margin: const EdgeInsets.only(
            bottom: Dimens.marginPaddingSizeXMini,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimens.mediumComponentRadius)),
            border: Border.all(color: theme.dividerColor),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarkTopicShowPage(topic: topic),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                topic.title ?? "",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              topic.code ?? "",
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                topic.description ?? "",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.rate_review),
                              onPressed: () => onItemApproved.call(topic),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${topic.lecturer?.name} (Lecturer)',
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${topic.critical?.name} (Critical)',
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
