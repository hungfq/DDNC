import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_schedule_today_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/schedule_repository.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_list_event.dart';
import 'register_list_state.dart';

class RegisterListBloc extends Bloc<RegisterListEvent, RegisterListState> {
  RegisterListBloc(
      {required TopicRepository topicRepository,
      required ScheduleRepository scheduleRepository})
      : _topicRepository = topicRepository,
        _scheduleRepository = scheduleRepository,
        super(RegisterTopicListFetchedState(Resource.loading())) {
    on<RegisterScheduleListFetchedEvent>(
      _onScheduleFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    // on<RegisterTopicListFetchedEvent>(
    //   _onTopicFetched,
    //   transformer: throttleDroppable(Constants.throttleDuration),
    // );
    // on<RegisterTopicListLoadMoreEvent>(
    //   _onLoadMore,
    //   transformer: throttleDroppable(Constants.throttleDuration),
    // );
    // on<RegisterTopicListSearchedEvent>(
    //   _onSearched,
    //   transformer: debounce(Constants.filterDelayTime),
    // );
    // on<RegisterTopicListRefreshedEvent>(
    //   _onRefreshed,
    //   transformer: throttleDroppable(Constants.throttleDuration),
    // );
    // on<RegisterTopicListDataChangedEvent>(
    //   _onDataChanged,
    // );
  }

  final TopicRepository _topicRepository;
  final ScheduleRepository _scheduleRepository;
  String _keyword = "";
  Resource<ListTopicResponse> _getListRegisterTopicResult = Resource.loading();
  Resource<ListScheduleTodayResponse> _getListRegisterScheduleResult =
      Resource.loading();

  //region getters & setters
  set keyword(String keyword) {
    keyword = keyword.trim().toUpperCase();
    _keyword = keyword;
    add(RegisterTopicListDataChangedEvent(
        RegisterTopicListDataChangedEvent.keywordChanged, keyword));
  }

  Resource<ListTopicResponse> get getListRegisterTopicResult =>
      _getListRegisterTopicResult;

  Resource<ListScheduleTodayResponse> get getListRegisterScheduleResult =>
      _getListRegisterScheduleResult;

  int get currentPage =>
      _getListRegisterTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage =>
      _getListRegisterTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get topicList => _getListRegisterTopicResult.data?.data ?? [];

  Future<void> _onScheduleFetched(
    RegisterScheduleListFetchedEvent event,
    Emitter<RegisterListState> emit,
  ) async =>
      _scheduleFetch(emit);

// Future<void> _onTopicFetched(
//   RegisterTopicListFetchedEvent event,
//   Emitter<RegisterListState> emit,
// ) async =>
//     _fetch(emit);
//
// Future<void> _onSearched(
//   RegisterTopicListSearchedEvent event,
//   Emitter<RegisterListState> emit,
// ) async =>
//     _fetch(emit);
//
// Future<void> _onRefreshed(
//   RegisterTopicListRefreshedEvent event,
//   Emitter<RegisterListState> emit,
// ) async {
//   var result = await _topicRepository.listTopic(
//     _keyword,
//     null,
//     '1',
//     null,
//     1,
//     currentPage * Constants.itemPerPage,
//   );
//   if (result.state == Result.success) {
//     _getListRegisterTopicResult = _getListRegisterTopicResult.copyWith(
//       data: ListTopicResponse(
//         result.data?.data ?? [],
//         _getListRegisterTopicResult.data!.meta,
//       ),
//     );
//   }
//   emit(RegisterTopicListRefreshedState(result));
// }
//
// Future<void> _onLoadMore(
//   RegisterTopicListLoadMoreEvent event,
//   Emitter<RegisterListState> emit,
// ) async {
//   if (currentPage == totalPage) {
//     emit(RegisterTopicListLoadMoreState(_getListRegisterTopicResult));
//   } else {
//     var nextPage = currentPage + 1;
//
//     var result = await _topicRepository.listTopic(
//         _keyword, null, '1', null, nextPage);
//     if (result.state == Result.success) {
//       _getListRegisterTopicResult = _getListRegisterTopicResult.copyWith(
//         data: ListRegisterTopicResponse(
//           [
//             ...topicList,
//             ...result.data?.data ?? [],
//           ],
//           result.data!.meta,
//         ),
//       );
//     }
//     emit(RegisterTopicListLoadMoreState(result));
//   }
// }
//
// Future<void> _onDataChanged(
//   RegisterTopicListDataChangedEvent event,
//   Emitter<RegisterListState> emit,
// ) async {
//   emit(RegisterTopicListDataChangedState(event.event, event.data));
// }
//
// //region actions

  void fetchSchedule() {
    add(const RegisterScheduleListFetchedEvent());
  }

  Future<List<ScheduleInfo>> forceFetchRegisterSchedule() async {
    var result = await _scheduleRepository.listScheduleToday();
    return result.data?.register ?? [];
  }

// void fetch() {
//   add(const RegisterTopicListFetchedEvent());
// }
//
// void loadMore() {
//   add(const RegisterTopicListLoadMoreEvent());
// }
//
// void search(String search) {
//   _keyword = search;
//   add(const RegisterTopicListFetchedEvent());
// }
//
// void _fetch(Emitter<RegisterListState> emit) async {
//   emit(RegisterTopicListFetchedState(Resource.loading()));
//
//   var result = await _topicRepository.listTopic(
//     _keyword,
//     null,
//     '1',
//     null,
//   );
//   _getListRegisterTopicResult = result;
//
//   emit(RegisterTopicListFetchedState(_getListRegisterTopicResult));
// }

  void _scheduleFetch(Emitter<RegisterListState> emit) async {
    emit(RegisterScheduleFetchedState(Resource.loading()));

    var result = await _scheduleRepository.listScheduleToday();
    _getListRegisterScheduleResult = result;

    emit(RegisterScheduleFetchedState(_getListRegisterScheduleResult));
  }
}
