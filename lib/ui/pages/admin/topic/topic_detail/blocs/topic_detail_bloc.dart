import 'package:ddnc_new/api/request/update_topic_request.dart';
import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'topic_detail_event.dart';
import 'topic_detail_state.dart';

class TopicDetailBloc extends Bloc<TopicDetailEvent, TopicDetailState> {
  TopicDetailBloc({
    required TopicRepository topicRepository,
    // required UserRepository userRepository,
  })  : _topicRepository = topicRepository,
        // _userRepository = userRepository,
        super(TopicDetailFetchedState(Resource.loading())) {
    on<TopicUpdatedEvent>(
      _onTopicUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<UsersFetchedEvent>(
      _onUsersFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicRepository _topicRepository;

  // final UserRepository _userRepository;
  late int topicId;
  Resource<List<UserInfo>> _userFetchedResult = Resource.loading();

  Resource<List<UserInfo>> get userFetchedResult => _userFetchedResult;

  List<UserInfo> get userList => _userFetchedResult.data ?? [];

  Future<void> _onTopicUpdated(
    TopicUpdatedEvent event,
    Emitter<TopicDetailState> emit,
  ) async {
    emit(TopicUpdatedState(Resource.loading()));

    var result = await _topicRepository.updateTopic(
      topicId: topicId,
      request: event.request,
    );

    emit(TopicUpdatedState(result));
  }

  Future<void> _onUsersFetched(
    UsersFetchedEvent event,
    Emitter<TopicDetailState> emit,
  ) async {
    emit(UsersFetchedState(_userFetchedResult));

    var result = await _topicRepository.getUsers(event.search, event.type);

    _userFetchedResult = result;
    emit(UsersFetchedState(_userFetchedResult));
  }

  void updateTopic(
      {required String code,
      required String title,
      String? description,
      int? limit,
      String? thesisDefenseDate,
      int? scheduleId,
      int? lecturerId,
      int? criticalLecturerId,
      double? advisorLecturerGrade,
      double? criticalLecturerGrade,
      double? committeePresidentGrade,
      double? committeeSecretaryGrade,
      List? students}) {
    add(TopicUpdatedEvent(UpdateTopicRequest(
      code,
      title,
      description,
      limit!,
      thesisDefenseDate,
      scheduleId,
      lecturerId,
      criticalLecturerId,
      advisorLecturerGrade,
      criticalLecturerGrade,
      committeePresidentGrade,
      committeeSecretaryGrade,
      students ?? [],
    )));
  }

  void fetchUser(String search, String type) async {
    add(UsersFetchedEvent(search, type));
  }

  Future<List<UserInfo>> forceFetchUser(String search, String type) async {
    var result = await _topicRepository.getUsers(search, type);
    return result.data ?? [];
  }

  Future<List<ScheduleInfo>> forceFetchSchedule() async {
    var result = await _topicRepository.getSchedules();
    return result.data ?? [];
  }
}
