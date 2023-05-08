import 'package:ddnc_new/api/request/mark_topic_request.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mark_event.dart';
import 'mark_state.dart';

class LecturerMarkBloc extends Bloc<LecturerMarkEvent, LecturerMarkState> {
  LecturerMarkBloc({required TopicRepository topicRepository})
      : _topicRepository = topicRepository,
        super(
          LecturerTopicFetchedState(Resource.loading()),
        ) {
    on<LecturerTopicFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerTopicLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerTopicRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerMarkedEvent>(
      _onLecturerMark,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicRepository _topicRepository;
  Resource<ListTopicResponse> _getTopicResult = Resource.loading();
  late int _TYPE;

//region getters & setters

  Resource<ListTopicResponse> get getTopicResult => _getTopicResult;

  int get currentAdvisorPage =>
      _getTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalAdvisorPage =>
      _getTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get advisorTopicList => _getTopicResult.data?.data ?? [];

  set TYPE(int type) {
    _TYPE = type;
  }

//endregion

  Future<void> _onFetched(
    LecturerTopicFetchedEvent event,
    Emitter<LecturerMarkState> emit,
  ) async =>
      _fetchTopic(emit);

  Future<void> _onRefreshed(
    LecturerTopicRefreshedEvent event,
    Emitter<LecturerMarkState> emit,
  ) async {
    var result = await _topicRepository.listTopicToMark(
      _TYPE,
      1,
      currentAdvisorPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getTopicResult = _getTopicResult.copyWith(
        data: ListTopicResponse(
          result.data?.data ?? [],
          _getTopicResult.data!.meta,
        ),
      );
    }
    emit(LecturerTopicRefreshedState(result));
  }

  Future<void> _onLoadMore(
    LecturerTopicLoadMoreEvent event,
    Emitter<LecturerMarkState> emit,
  ) async {
    if (currentAdvisorPage == totalAdvisorPage) {
      emit(LecturerTopicLoadMoreState(_getTopicResult));
    } else {
      var nextPage = currentAdvisorPage + 1;

      var result = await _topicRepository.listTopicToMark(_TYPE, nextPage);
      if (result.state == Result.success) {
        _getTopicResult = _getTopicResult.copyWith(
          data: ListTopicResponse(
            [
              ...advisorTopicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(LecturerTopicLoadMoreState(result));
    }
  }

  Future<void> _onLecturerMark(
    LecturerMarkedEvent event,
    Emitter<LecturerMarkState> emit,
  ) async {
    emit(LecturerMarkedState(Resource.loading()));

    var result = await _topicRepository.markTopic(
        topicId: event.topicId, request: event.request);

    emit(LecturerMarkedState(result));
  }

// region actions

  void fetch() {
    add(const LecturerTopicFetchedEvent());
  }

  void loadMore() {
    add(const LecturerTopicLoadMoreEvent());
  }

  void mark(int topicId, String grade) {
    var request = null;
    switch (_TYPE) {
      case 1:
        request = MarkTopicRequest(grade, "", "", "");
        break;
      case 2:
        request = MarkTopicRequest("", grade, "", "");
        break;
      case 3:
        request = MarkTopicRequest("", "", grade, "");
        break;
      case 4:
        request = MarkTopicRequest("", "", "", grade);
        break;
      default:
        request = MarkTopicRequest("", "", "", "");
    }
    add(LecturerMarkedEvent(topicId, request));
  }

//endregion

  void _fetchTopic(Emitter<LecturerMarkState> emit) async {
    emit(LecturerTopicFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicToMark(_TYPE);
    _getTopicResult = result;

    emit(LecturerTopicFetchedState(_getTopicResult));
  }
}
