import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'approve_event.dart';
import 'approve_state.dart';

class LecturerApproveBloc
    extends Bloc<LecturerApproveEvent, LecturerApproveState> {
  LecturerApproveBloc(
      {required TopicRepository topicRepository})
      : _topicRepository = topicRepository,
        super(
          LecturerAdvisorTopicFetchedState(Resource.loading()),
          //   LecturerCriticalTopicFetchedState(Resource.loading()),
        ) {
    on<LecturerAdvisorTopicFetchedEvent>(
      _onAdvisorTopicFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerCriticalTopicFetchedEvent>(
      _onCriticalTopicFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerAdvisorTopicLoadMoreEvent>(
      _onAdvisorTopicLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerCriticalTopicLoadMoreEvent>(
      _onCriticalTopicLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerAdvisorTopicRefreshedEvent>(
      _onAdvisorTopicRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerCriticalTopicRefreshedEvent>(
      _onCriticalTopicRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerAdvisorApprovedEvent>(
      _onAdvisorApproved,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerCriticalApprovedEvent>(
      _onCriticalApproved,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerAdvisorDeclinedEvent>(
      _onAdvisorDeclined,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<LecturerCriticalDeclinedEvent>(
      _onCriticalDeclined,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicRepository _topicRepository;
  Resource<ListTopicResponse> _getAdvisorTopicResult = Resource.loading();
  Resource<ListTopicResponse> _getCriticalTopicResult = Resource.loading();

//region getters & setters

  Resource<ListTopicResponse> get getAdvisorTopicResult =>
      _getAdvisorTopicResult;

  Resource<ListTopicResponse> get getCriticalTopicResult =>
      _getCriticalTopicResult;

  int get currentAdvisorPage =>
      _getAdvisorTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get currentCriticalPage =>
      _getCriticalTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalAdvisorPage =>
      _getAdvisorTopicResult.data?.meta.pagination.totalPage ?? 1;

  int get totalCriticalPage =>
      _getCriticalTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get advisorTopicList =>
      _getAdvisorTopicResult.data?.data ?? [];

  List<TopicInfo> get criticalTopicList =>
      _getCriticalTopicResult.data?.data ?? [];

  //endregion

  Future<void> _onAdvisorTopicFetched(
    LecturerAdvisorTopicFetchedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async =>
      _fetchAdvisorTopic(emit);

  Future<void> _onCriticalTopicFetched(
    LecturerCriticalTopicFetchedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async =>
      _fetchCriticalTopic(emit);

  Future<void> _onAdvisorTopicRefreshed(
    LecturerAdvisorTopicRefreshedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    var result = await _topicRepository.listTopicAdvisorApprove(
      "",
      null,
      1,
      currentAdvisorPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getAdvisorTopicResult = _getAdvisorTopicResult.copyWith(
        data: ListTopicResponse(
          result.data?.data ?? [],
          _getAdvisorTopicResult.data!.meta,
        ),
      );
    }
    emit(LecturerAdvisorTopicRefreshedState(result));
  }

  Future<void> _onCriticalTopicRefreshed(
    LecturerCriticalTopicRefreshedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    var result = await _topicRepository.listTopicCriticalApprove(
      "",
      null,
      1,
      currentCriticalPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getCriticalTopicResult = _getCriticalTopicResult.copyWith(
        data: ListTopicResponse(
          result.data?.data ?? [],
          _getCriticalTopicResult.data!.meta,
        ),
      );
    }
    emit(LecturerAdvisorTopicRefreshedState(result));
  }

  Future<void> _onAdvisorTopicLoadMore(
    LecturerAdvisorTopicLoadMoreEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    if (currentAdvisorPage == totalAdvisorPage) {
      emit(LecturerAdvisorTopicLoadMoreState(_getAdvisorTopicResult));
    } else {
      var nextPage = currentAdvisorPage + 1;

      var result =
          await _topicRepository.listTopicAdvisorApprove("", null, nextPage);
      if (result.state == Result.success) {
        _getAdvisorTopicResult = _getAdvisorTopicResult.copyWith(
          data: ListTopicResponse(
            [
              ...advisorTopicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(LecturerAdvisorTopicLoadMoreState(result));
    }
  }

  Future<void> _onCriticalTopicLoadMore(
    LecturerCriticalTopicLoadMoreEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    if (currentCriticalPage == totalCriticalPage) {
      emit(LecturerCriticalTopicLoadMoreState(_getCriticalTopicResult));
    } else {
      var nextPage = currentCriticalPage + 1;

      var result =
          await _topicRepository.listTopicCriticalApprove("", null, nextPage);
      if (result.state == Result.success) {
        _getCriticalTopicResult = _getCriticalTopicResult.copyWith(
          data: ListTopicResponse(
            [
              ...criticalTopicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(LecturerCriticalTopicLoadMoreState(result));
    }
  }

  Future<void> _onAdvisorApproved(
    LecturerAdvisorApprovedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    emit(LecturerAdvisorApprovedState(Resource.loading()));

    var result = await _topicRepository.advisorApproveToCommittee(
        topicId: event.topicId);
    emit(LecturerAdvisorApprovedState(result));
  }

  Future<void> _onCriticalApproved(
    LecturerCriticalApprovedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    emit(LecturerCriticalApprovedState(Resource.loading()));

    var result = await _topicRepository.criticalApproveToCommittee(
        topicId: event.topicId);
    emit(LecturerCriticalApprovedState(result));
  }

  Future<void> _onAdvisorDeclined(
    LecturerAdvisorDeclinedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    emit(LecturerAdvisorDeclinedState(Resource.loading()));

    var result = await _topicRepository.advisorDeclineToCommittee(
        topicId: event.topicId);
    emit(LecturerAdvisorDeclinedState(result));
  }

  Future<void> _onCriticalDeclined(
    LecturerCriticalDeclinedEvent event,
    Emitter<LecturerApproveState> emit,
  ) async {
    emit(LecturerCriticalDeclinedState(Resource.loading()));

    var result = await _topicRepository.criticalDeclineToCommittee(
        topicId: event.topicId);
    emit(LecturerCriticalDeclinedState(result));
  }

// region actions

  void fetchAdvisorTopic() {
    add(const LecturerAdvisorTopicFetchedEvent());
  }

  void fetchCriticalTopic() {
    add(const LecturerCriticalTopicFetchedEvent());
  }

  void loadMoreAdvisorTopic() {
    add(const LecturerAdvisorTopicLoadMoreEvent());
  }

  void loadMoreCriticalTopic() {
    add(const LecturerCriticalTopicLoadMoreEvent());
  }

  void advisorApprove(int topicId) {
    add(LecturerAdvisorApprovedEvent(topicId));
  }

  void criticalApprove(int topicId) {
    add(LecturerCriticalApprovedEvent(topicId));
  }

  void advisorDecline(int topicId) {
    add(LecturerAdvisorDeclinedEvent(topicId));
  }

  void criticalDecline(int topicId) {
    add(LecturerCriticalDeclinedEvent(topicId));
  }

  //endregion

  void _fetchAdvisorTopic(Emitter<LecturerApproveState> emit) async {
    emit(LecturerAdvisorTopicFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicAdvisorApprove("", null);
    _getAdvisorTopicResult = result;

    emit(LecturerAdvisorTopicFetchedState(_getAdvisorTopicResult));
  }

  void _fetchCriticalTopic(Emitter<LecturerApproveState> emit) async {
    emit(LecturerCriticalTopicFetchedState(Resource.loading()));

    var result = await _topicRepository.listTopicCriticalApprove("", null);
    _getCriticalTopicResult = result;

    emit(LecturerCriticalTopicFetchedState(_getCriticalTopicResult));
  }
}
