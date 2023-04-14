import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'topic_list_event.dart';
import 'topic_list_state.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  TopicListBloc({required TopicRepository topicRepository})
      : _topicRepository = topicRepository,
        super(TopicListFetchedState(Resource.loading())) {
    on<TopicListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicListSearchedEvent>(
      _onSearched,
      transformer: debounce(Constants.filterDelayTime),
    );
    on<TopicListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicListDataChangedEvent>(
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
    add(TopicListDataChangedEvent(
        TopicListDataChangedEvent.keywordChanged, keyword));
  }

  Resource<ListTopicResponse> get getListTopicResult => _getListTopicResult;

  int get currentPage =>
      _getListTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage => _getListTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get topicList => _getListTopicResult.data?.data ?? [];

  Future<void> _onFetched(
    TopicListFetchedEvent event,
    Emitter<TopicListState> emit,
  ) async =>
    _fetch(emit);


  Future<void> _onSearched(
      TopicListSearchedEvent event,
      Emitter<TopicListState> emit,
      ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    TopicListRefreshedEvent event,
    Emitter<TopicListState> emit,
  ) async {
    var result = await _topicRepository.listTopic(
      _keyword,
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
    emit(TopicListRefreshedState(result));
  }

  Future<void> _onLoadMore(
    TopicListLoadMoreEvent event,
    Emitter<TopicListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(TopicListLoadMoreState(_getListTopicResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _topicRepository.listTopic(_keyword, nextPage);
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
      emit(TopicListLoadMoreState(result));
    }
  }

  Future<void> _onDataChanged(
    TopicListDataChangedEvent event,
    Emitter<TopicListState> emit,
  ) async {
    emit(TopicListDataChangedState(event.event, event.data));
  }

  //region actions
  void fetch() {
    add(const TopicListFetchedEvent());
  }

  void loadMore() {
    add(const TopicListLoadMoreEvent());
  }

  void search(String search) {
    _keyword = search;
    add(const TopicListFetchedEvent());
  }

  void _fetch(Emitter<TopicListState> emit) async {
    emit(TopicListFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopic(_keyword);
    _getListTopicResult = result;

    emit(TopicListFetchedState(_getListTopicResult));
  }
}
