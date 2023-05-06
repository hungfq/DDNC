import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'topic_list_event.dart';
import 'topic_list_state.dart';

class LecturerTopicListBloc extends Bloc<LecturerTopicListEvent, LecturerTopicListState> {
  LecturerTopicListBloc({required TopicRepository topicRepository})
      : _topicRepository = topicRepository,
        super(LecturerTopicListFetchedState(Resource.loading())) {
    on<LecturerTopicListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerTopicListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerTopicListSearchedEvent>(
      _onSearched,
      transformer: debounce(Constants.filterDelayTime),
    );
    on<LecturerTopicListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerTopicListDataChangedEvent>(
      _onDataChanged,
    );
  }

  final TopicRepository _topicRepository;
  String _keyword = "";
  Resource<ListTopicResponse> _getListTopicResult = Resource.loading();

  //region getters & setters
  set keyword(String keyword) {
    keyword = keyword.trim().toUpperCase();
    _keyword = keyword;
    add(LecturerTopicListDataChangedEvent(
        LecturerTopicListDataChangedEvent.keywordChanged, keyword));
  }

  Resource<ListTopicResponse> get getListTopicResult => _getListTopicResult;

  int get currentPage =>
      _getListTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage => _getListTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get topicList => _getListTopicResult.data?.data ?? [];

  Future<void> _onFetched(
    LecturerTopicListFetchedEvent event,
    Emitter<LecturerTopicListState> emit,
  ) async =>
    _fetch(emit);


  Future<void> _onSearched(
      LecturerTopicListSearchedEvent event,
      Emitter<LecturerTopicListState> emit,
      ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    LecturerTopicListRefreshedEvent event,
    Emitter<LecturerTopicListState> emit,
  ) async {
    var result = await _topicRepository.listTopicLecturer(
      _keyword,
      null,
      1,
      currentPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getListTopicResult = _getListTopicResult.copyWith(
        data: ListTopicResponse(
          result.data?.data ?? [],
          _getListTopicResult.data!.meta,
        ),
      );
    }
    emit(LecturerTopicListRefreshedState(result));
  }

  Future<void> _onLoadMore(
    LecturerTopicListLoadMoreEvent event,
    Emitter<LecturerTopicListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(LecturerTopicListLoadMoreState(_getListTopicResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _topicRepository.listTopicLecturer(_keyword, null, nextPage);
      if (result.state == Result.success) {
        _getListTopicResult = _getListTopicResult.copyWith(
          data: ListTopicResponse(
            [
              ...topicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(LecturerTopicListLoadMoreState(result));
    }
  }

  Future<void> _onDataChanged(
    LecturerTopicListDataChangedEvent event,
    Emitter<LecturerTopicListState> emit,
  ) async {
    emit(LecturerTopicListDataChangedState(event.event, event.data));
  }

  //region actions
  void fetch() {
    add(const LecturerTopicListFetchedEvent());
  }

  void loadMore() {
    add(const LecturerTopicListLoadMoreEvent());
  }

  void search(String search) {
    _keyword = search;
    add(const LecturerTopicListFetchedEvent());
  }

  void _fetch(Emitter<LecturerTopicListState> emit) async {
    emit(LecturerTopicListFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicLecturer(_keyword, null);
    _getListTopicResult = result;

    emit(LecturerTopicListFetchedState(_getListTopicResult));
  }
}
