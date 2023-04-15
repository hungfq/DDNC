import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/committee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'committee_list_event.dart';
import 'committee_list_state.dart';

class CommitteeListBloc extends Bloc<CommitteeListEvent, CommitteeListState> {
  CommitteeListBloc({required CommitteeRepository committeeRepository})
      : _committeeRepository = committeeRepository,
        super(CommitteeListFetchedState(Resource.loading())) {
    on<CommitteeListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<CommitteeListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<CommitteeListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<CommitteeListSearchedEvent>(
      _onSearched,
      transformer: debounce(Constants.filterDelayTime),
    );
    on<CommitteeListDataChangedEvent>(
      _onDataChanged,
    );
  }

  final CommitteeRepository _committeeRepository;
  late int committeeId;
  String _search = "";
  Resource<ListCommitteeResponse> _getListUserResult = Resource.loading();

  Resource<ListCommitteeResponse> get getListUserResult => _getListUserResult;

  int get currentPage =>
      _getListUserResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage => _getListUserResult.data?.meta.pagination.totalPage ?? 1;

  List<CommitteeInfo> get committeeList => _getListUserResult.data?.data ?? [];

  Future<void> _onFetched(
    CommitteeListFetchedEvent event,
    Emitter<CommitteeListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onSearched(
    CommitteeListSearchedEvent event,
    Emitter<CommitteeListState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onLoadMore(
    CommitteeListLoadMoreEvent event,
    Emitter<CommitteeListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(CommitteeListLoadMoreState(_getListUserResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _committeeRepository.listCommittee(_search, nextPage);
      if (result.state == Result.success) {
        _getListUserResult = _getListUserResult.copyWith(
          data: ListCommitteeResponse(
            [
              ...committeeList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(CommitteeListLoadMoreState(result));
    }
  }

  Future<void> _onRefreshed(
    CommitteeListRefreshedEvent event,
    Emitter<CommitteeListState> emit,
  ) async {
    var result = await _committeeRepository.listCommittee(_search);
    if (result.state == Result.success) {
      _getListUserResult = _getListUserResult.copyWith(
        data: ListCommitteeResponse(
          result.data?.data ?? [],
          _getListUserResult.data!.meta,
        ),
      );
    }
    emit(CommitteeListRefreshedState(result));
  }

  Future<void> _onDataChanged(
    CommitteeListDataChangedEvent event,
    Emitter<CommitteeListState> emit,
  ) async {
    emit(CommitteeListDataChangedState(event.event, event.data));
  }

  void refresh() {
    add(const CommitteeListRefreshedEvent());
  }

  //region actions
  void fetch() {
    add(const CommitteeListFetchedEvent());
  }

  void loadMore() {
    add(const CommitteeListLoadMoreEvent());
  }

  void search(String search) {
    _search = search;
    add(const CommitteeListFetchedEvent());
  }

  void _fetch(Emitter<CommitteeListState> emit) async {
    emit(CommitteeListFetchedState(Resource.loading()));

    var result = await _committeeRepository.listCommittee(_search);
    _getListUserResult = result;

    emit(CommitteeListFetchedState(_getListUserResult));
  }
}
