import 'package:ddnc_new/api/request/update_schedule_request.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/schedule_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'schedule_detail_event.dart';
import 'schedule_detail_state.dart';

class ScheduleDetailBloc
    extends Bloc<ScheduleDetailEvent, ScheduleDetailState> {
  ScheduleDetailBloc({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository,
        super(ScheduleDetailFetchedState(Resource.loading())) {
    on<ScheduleCreatedEvent>(
      _onScheduleCreated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ScheduleUpdatedEvent>(
      _onScheduleUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ScheduleDeletedEvent>(
      _onScheduleDeleted,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final ScheduleRepository _scheduleRepository;
  late int scheduleId;

  Future<void> _onScheduleCreated(
    ScheduleCreatedEvent event,
    Emitter<ScheduleDetailState> emit,
  ) async {
    emit(ScheduleCreatedState(Resource.loading()));

    var result = await _scheduleRepository.createSchedule(
      request: event.request,
    );

    emit(ScheduleCreatedState(result));
  }

  Future<void> _onScheduleUpdated(
    ScheduleUpdatedEvent event,
    Emitter<ScheduleDetailState> emit,
  ) async {
    emit(ScheduleUpdatedState(Resource.loading()));

    var result = await _scheduleRepository.updateSchedule(
      scheduleId: scheduleId,
      request: event.request,
    );

    emit(ScheduleUpdatedState(result));
  }

  Future<void> _onScheduleDeleted(
    ScheduleDeletedEvent event,
    Emitter<ScheduleDetailState> emit,
  ) async {
    emit(ScheduleDeletedState(Resource.loading()));

    var result = await _scheduleRepository.deleteSchedule(
      scheduleId: scheduleId,
    );

    emit(ScheduleUpdatedState(result));
  }

  void createSchedule(
      {required String code,
      required String name,
      String? description,
      String? startDate,
      String? deadline,
      String? startProposalDate,
      String? endProposalDate,
      String? startApproveDate,
      String? endApproveDate,
      String? startRegisterDate,
      String? endRegisterDate,
      List? students}) {
    add(ScheduleCreatedEvent(UpdateScheduleRequest(
        code,
        name,
        description,
        startDate,
        deadline,
        startProposalDate,
        endProposalDate,
        startApproveDate,
        endApproveDate,
        startRegisterDate,
        endRegisterDate,
        students ?? [])));
  }

  void updateSchedule(
      {required String code,
      required String name,
      String? description,
      String? startDate,
      String? deadline,
      String? startProposalDate,
      String? endProposalDate,
      String? startApproveDate,
      String? endApproveDate,
      String? startRegisterDate,
      String? endRegisterDate,
      List? students}) {
    add(ScheduleUpdatedEvent(UpdateScheduleRequest(
        code,
        name,
        description,
        startDate,
        deadline,
        startProposalDate,
        endProposalDate,
        startApproveDate,
        endApproveDate,
        startRegisterDate,
        endRegisterDate,
        students ?? [])));
  }

  void deleteSchedule() {
    add(ScheduleDeletedEvent());
  }

  Future<List<UserInfo>> forceFetchUser(String search, String type) async {
    var result = await _scheduleRepository.getUsers(search, type);
    return result.data ?? [];
  }
}
