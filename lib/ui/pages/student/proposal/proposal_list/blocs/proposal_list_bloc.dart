import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'proposal_list_event.dart';
import 'proposal_list_state.dart';

class TopicProposalListBloc
    extends Bloc<TopicProposalListEvent, TopicProposalListState> {
  TopicProposalListBloc({required TopicProposalRepository topicRepository})
      : _topicRepository = topicRepository,
        super(TopicProposalListFetchedState(Resource.loading())) {
    on<TopicProposalListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicProposalListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicProposalListSearchedEvent>(
      _onSearched,
      transformer: debounce(Constants.filterDelayTime),
    );
    on<TopicProposalListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicProposalListDataChangedEvent>(
      _onDataChanged,
    );
  }

  final TopicProposalRepository _topicRepository;
  String _keyword = "";
  Resource<ListTopicProposalResponse> _getListTopicProposalResult =
      Resource.loading();

  //region getters & setters
  set keyword(String keyword) {
    keyword = keyword.trim().toUpperCase();
    _keyword = keyword;
    add(TopicProposalListDataChangedEvent(
        TopicProposalListDataChangedEvent.keywordChanged, keyword));
  }

  Resource<ListTopicProposalResponse> get getListTopicProposalResult =>
      _getListTopicProposalResult;

  int get currentPage =>
      _getListTopicProposalResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage =>
      _getListTopicProposalResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicProposalInfo> get topicList =>
      _getListTopicProposalResult.data?.data ?? [];

  Future<void> _onFetched(
    TopicProposalListFetchedEvent event,
    Emitter<TopicProposalListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onSearched(
    TopicProposalListSearchedEvent event,
    Emitter<TopicProposalListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    TopicProposalListRefreshedEvent event,
    Emitter<TopicProposalListState> emit,
  ) async {
    var result = await _topicRepository.listTopicProposal(
      _keyword,
      null,
      '1',
      null,
      1,
      currentPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getListTopicProposalResult = _getListTopicProposalResult.copyWith(
        data: ListTopicProposalResponse(
          result.data?.data ?? [],
          _getListTopicProposalResult.data!.meta,
        ),
      );
    }
    emit(TopicProposalListRefreshedState(result));
  }

  Future<void> _onLoadMore(
    TopicProposalListLoadMoreEvent event,
    Emitter<TopicProposalListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(TopicProposalListLoadMoreState(_getListTopicProposalResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _topicRepository.listTopicProposal(
          _keyword, null, '1', null, nextPage);
      if (result.state == Result.success) {
        _getListTopicProposalResult = _getListTopicProposalResult.copyWith(
          data: ListTopicProposalResponse(
            [
              ...topicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(TopicProposalListLoadMoreState(result));
    }
  }

  Future<void> _onDataChanged(
    TopicProposalListDataChangedEvent event,
    Emitter<TopicProposalListState> emit,
  ) async {
    emit(TopicProposalListDataChangedState(event.event, event.data));
  }

  //region actions
  void fetch() {
    add(const TopicProposalListFetchedEvent());
  }

  void loadMore() {
    add(const TopicProposalListLoadMoreEvent());
  }

  void search(String search) {
    _keyword = search;
    add(const TopicProposalListFetchedEvent());
  }

  void _fetch(Emitter<TopicProposalListState> emit) async {
    emit(TopicProposalListFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicProposal(
      _keyword,
      null,
      '1',
      null,
    );
    _getListTopicProposalResult = result;

    emit(TopicProposalListFetchedState(_getListTopicProposalResult));
  }
}
