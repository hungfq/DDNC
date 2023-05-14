import 'package:ddnc_new/api/request/update_committee_request.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/committee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'committee_detail_event.dart';
import 'committee_detail_state.dart';

class CommitteeDetailBloc
    extends Bloc<CommitteeDetailEvent, CommitteeDetailState> {
  CommitteeDetailBloc({required CommitteeRepository committeeRepository})
      : _committeeRepository = committeeRepository,
        super(CommitteeDetailFetchedState(Resource.loading())) {
    on<CommitteeCreatedEvent>(
      _onCommitteeCreated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<CommitteeUpdatedEvent>(
      _onCommitteeUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<CommitteeDeletedEvent>(
      _onCommitteeDeleted,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final CommitteeRepository _committeeRepository;
  late int committeeId;

  Future<void> _onCommitteeCreated(
    CommitteeCreatedEvent event,
    Emitter<CommitteeDetailState> emit,
  ) async {
    emit(CommitteeCreatedState(Resource.loading()));

    var result = await _committeeRepository.createCommittee(
      request: event.request,
    );

    emit(CommitteeCreatedState(result));
  }

  Future<void> _onCommitteeUpdated(
    CommitteeUpdatedEvent event,
    Emitter<CommitteeDetailState> emit,
  ) async {
    emit(CommitteeUpdatedState(Resource.loading()));

    var result = await _committeeRepository.updateCommittee(
      committeeId: committeeId,
      request: event.request,
    );

    emit(CommitteeUpdatedState(result));
  }

  Future<void> _onCommitteeDeleted(
    CommitteeDeletedEvent event,
    Emitter<CommitteeDetailState> emit,
  ) async {
    emit(CommitteeDeletedState(Resource.loading()));

    var result = await _committeeRepository.deleteCommittee(
      committeeId: committeeId,
    );

    emit(CommitteeUpdatedState(result));
  }

  void createCommittee({
    required String code,
    required String name,
    int? committeePresidentId,
    int? committeeSecretaryId,
    int? criticalLecturerId,
    List? topics,
  }) {
    add(CommitteeCreatedEvent(UpdateCommitteeRequest(
        code,
        name,
        committeePresidentId,
        committeeSecretaryId,
        criticalLecturerId,
        topics ?? [])));
  }

  void updateCommittee({
    required String code,
    required String name,
    int? committeePresidentId,
    int? committeeSecretaryId,
    int? criticalLecturerId,
    List? topics,
  }) {
    add(CommitteeUpdatedEvent(UpdateCommitteeRequest(
        code,
        name,
        committeePresidentId,
        committeeSecretaryId,
        criticalLecturerId,
        topics ?? [])));
  }

  void deleteCommittee() {
    add(CommitteeDeletedEvent());
  }

  Future<List<UserInfo>> forceFetchUser(String search, String type) async {
    var result = await _committeeRepository.getUsers(search, type);
    return result.data ?? [];
  }

  Future<List<TopicInfo>> forceFetchTopic() async {
    var result = await _committeeRepository.getTopic();
    return result.data ?? [];
  }
}
