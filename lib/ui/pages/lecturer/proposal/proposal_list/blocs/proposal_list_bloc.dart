import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'proposal_list_event.dart';
import 'proposal_list_state.dart';

class ApproveProposalListBloc
    extends Bloc<ApproveProposalListEvent, ApproveProposalListState> {
  ApproveProposalListBloc({required TopicProposalRepository topicRepository})
      : _topicRepository = topicRepository,
        super(ApproveProposalListFetchedState(Resource.loading())) {
    on<ApproveProposalListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ApproveProposalListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ApproveProposalListSearchedEvent>(
      _onSearched,
      transformer: debounce(Constants.filterDelayTime),
    );
    on<ApproveProposalListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ApproveProposalListDataChangedEvent>(
      _onDataChanged,
    );
  }

  final TopicProposalRepository _topicRepository;
  String _keyword = "";
  Resource<ListTopicProposalResponse> _getListApproveProposalResult =
      Resource.loading();

  //region getters & setters
  set keyword(String keyword) {
    keyword = keyword.trim().toUpperCase();
    _keyword = keyword;
    add(ApproveProposalListDataChangedEvent(
        ApproveProposalListDataChangedEvent.keywordChanged, keyword));
  }

  Resource<ListTopicProposalResponse> get getListApproveProposalResult =>
      _getListApproveProposalResult;

  int get currentPage =>
      _getListApproveProposalResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage =>
      _getListApproveProposalResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicProposalInfo> get topicList =>
      _getListApproveProposalResult.data?.data ?? [];

  Future<void> _onFetched(
    ApproveProposalListFetchedEvent event,
    Emitter<ApproveProposalListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onSearched(
    ApproveProposalListSearchedEvent event,
    Emitter<ApproveProposalListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    ApproveProposalListRefreshedEvent event,
    Emitter<ApproveProposalListState> emit,
  ) async {
    var result = await _topicRepository.listTopicProposal(
      _keyword,
      null,
      null,
      '1',
      1,
      currentPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getListApproveProposalResult = _getListApproveProposalResult.copyWith(
        data: ListTopicProposalResponse(
          result.data?.data ?? [],
          _getListApproveProposalResult.data!.meta,
        ),
      );
    }
    emit(ApproveProposalListRefreshedState(result));
  }

  Future<void> _onLoadMore(
    ApproveProposalListLoadMoreEvent event,
    Emitter<ApproveProposalListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(ApproveProposalListLoadMoreState(_getListApproveProposalResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _topicRepository.listTopicProposal(
          _keyword, null, null, '1', nextPage);
      if (result.state == Result.success) {
        _getListApproveProposalResult = _getListApproveProposalResult.copyWith(
          data: ListTopicProposalResponse(
            [
              ...topicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(ApproveProposalListLoadMoreState(result));
    }
  }

  Future<void> _onDataChanged(
    ApproveProposalListDataChangedEvent event,
    Emitter<ApproveProposalListState> emit,
  ) async {
    emit(ApproveProposalListDataChangedState(event.event, event.data));
  }

  //region actions
  void fetch() {
    add(const ApproveProposalListFetchedEvent());
  }

  void loadMore() {
    add(const ApproveProposalListLoadMoreEvent());
  }

  void search(String search) {
    _keyword = search;
    add(const ApproveProposalListFetchedEvent());
  }

  void _fetch(Emitter<ApproveProposalListState> emit) async {
    emit(ApproveProposalListFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicProposal(
      _keyword,
      null,
      null,
      "1",
    );
    _getListApproveProposalResult = result;

    emit(ApproveProposalListFetchedState(_getListApproveProposalResult));
  }
}
