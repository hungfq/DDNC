import 'package:ddnc_new/api/request/update_topic_proposal_request.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'proposal_detail_event.dart';
import 'proposal_detail_state.dart';

class TopicProposalDetailBloc
    extends Bloc<TopicProposalDetailEvent, TopicProposalDetailState> {
  TopicProposalDetailBloc({
    required TopicProposalRepository topicRepository,
  })  : _proposalRepository = topicRepository,
        super(TopicProposalDetailFetchedState(Resource.loading())) {
    on<TopicProposalCreatedEvent>(
      _onTopicProposalCreated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicProposalUpdatedEvent>(
      _onTopicProposalUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<TopicProposalDeletedEvent>(
      _onTopicProposalDeleted,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<UsersFetchedEvent>(
      _onUsersFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicProposalRepository _proposalRepository;

  // final UserRepository _userRepository;
  late int topicId;
  Resource<List<UserInfo>> _userFetchedResult = Resource.loading();

  Resource<List<UserInfo>> get userFetchedResult => _userFetchedResult;

  List<UserInfo> get userList => _userFetchedResult.data ?? [];

  Future<void> _onTopicProposalCreated(
    TopicProposalCreatedEvent event,
    Emitter<TopicProposalDetailState> emit,
  ) async {
    emit(TopicProposalCreatedState(Resource.loading()));

    var result = await _proposalRepository.createTopicProposal(
      request: event.request,
    );

    emit(TopicProposalCreatedState(result));
  }

  Future<void> _onTopicProposalUpdated(
    TopicProposalUpdatedEvent event,
    Emitter<TopicProposalDetailState> emit,
  ) async {
    emit(TopicProposalUpdatedState(Resource.loading()));

    var result = await _proposalRepository.updateTopicProposal(
      topicId: topicId,
      request: event.request,
    );

    emit(TopicProposalUpdatedState(result));
  }

  Future<void> _onTopicProposalDeleted(
    TopicProposalDeletedEvent event,
    Emitter<TopicProposalDetailState> emit,
  ) async {
    emit(TopicProposalDeletedState(Resource.loading()));

    var result = await _proposalRepository.deleteTopicProposal(
      topicId: topicId,
    );

    emit(TopicProposalUpdatedState(result));
  }

  Future<void> _onUsersFetched(
    UsersFetchedEvent event,
    Emitter<TopicProposalDetailState> emit,
  ) async {
    emit(UsersFetchedState(_userFetchedResult));

    var result = await _proposalRepository.getUsers(event.search, event.type);

    _userFetchedResult = result;
    emit(UsersFetchedState(_userFetchedResult));
  }

  void createTopicProposal(
      {required String code,
      required String title,
      String? description,
      int? limit,
      int? scheduleId,
      int? lecturerId,
      List? students}) {
    add(TopicProposalCreatedEvent(UpdateTopicProposalRequest(
      code,
      title,
      description,
      limit!,
      scheduleId,
      lecturerId,
      students ?? [],
    )));
  }

  void updateTopicProposal(
      {required String code,
      required String title,
      String? description,
      int? limit,
      int? scheduleId,
      int? lecturerId,
      List? students}) {
    add(TopicProposalUpdatedEvent(UpdateTopicProposalRequest(
      code,
      title,
      description,
      limit!,
      scheduleId,
      lecturerId,
      students ?? [],
    )));
  }

  void deleteTopicProposal() {
    add(TopicProposalDeletedEvent());
  }

  void fetchUser(String search, String type) async {
    add(UsersFetchedEvent(search, type));
  }

  Future<List<UserInfo>> forceFetchUser(String search, String type) async {
    var result = await _proposalRepository.getUsers(search, type);
    return result.data ?? [];
  }

  Future<List<ScheduleInfo>> forceFetchSchedule() async {
    var result = await _proposalRepository.getSchedules();
    return result.data ?? [];
  }
}
