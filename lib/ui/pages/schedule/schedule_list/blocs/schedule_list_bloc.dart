import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/schedule_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'schedule_list_event.dart';
import 'schedule_list_state.dart';

class ScheduleListBloc extends Bloc<ScheduleListEvent, ScheduleListState> {
  ScheduleListBloc({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository,
        super(ScheduleListFetchedState(Resource.loading())) {
    on<ScheduleListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ScheduleListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ScheduleListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final ScheduleRepository _scheduleRepository;
  late int scheduleId;
  String _search = "";
  Resource<ListScheduleResponse> _getListUserResult = Resource.loading();

  Resource<ListScheduleResponse> get getListUserResult => _getListUserResult;

  int get currentPage =>
      _getListUserResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage => _getListUserResult.data?.meta.pagination.totalPage ?? 1;

  List<ScheduleInfo> get scheduleList => _getListUserResult.data?.data ?? [];

  Future<void> _onFetched(
    ScheduleListFetchedEvent event,
    Emitter<ScheduleListState> emit,
  ) async {
    emit(ScheduleListFetchedState(Resource.loading()));

    var result = await _scheduleRepository.listSchedule(_search);
    _getListUserResult = result;

    emit(ScheduleListFetchedState(_getListUserResult));
  }

  Future<void> _onLoadMore(
    ScheduleListLoadMoreEvent event,
    Emitter<ScheduleListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(ScheduleListLoadMoreState(_getListUserResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _scheduleRepository.listSchedule(_search, nextPage);
      if (result.state == Result.success) {
        _getListUserResult = _getListUserResult.copyWith(
          data: ListScheduleResponse(
            [
              ...scheduleList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(ScheduleListLoadMoreState(result));
    }
  }

  Future<void> _onRefreshed(
    ScheduleListRefreshedEvent event,
    Emitter<ScheduleListState> emit,
  ) async {
    var result = await _scheduleRepository.listSchedule(_search);
    if (result.state == Result.success) {
      _getListUserResult = _getListUserResult.copyWith(
        data: ListScheduleResponse(
          result.data?.data ?? [],
          _getListUserResult.data!.meta,
        ),
      );
    }
    emit(ScheduleListRefreshedState(result));
  }

  void refresh() {
    add(const ScheduleListRefreshedEvent());
  }

  //region actions
  void fetch() {
    add(const ScheduleListFetchedEvent());
  }

  void loadMore() {
    add(const ScheduleListLoadMoreEvent());
  }
}
