import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_detail_event.dart';
import 'register_detail_state.dart';

class RegisterDetailBloc
    extends Bloc<RegisterDetailEvent, RegisterDetailState> {
  RegisterDetailBloc({
    required TopicRepository topicRepository,
  })  : _topicRepository = topicRepository,
        super(RegisterDetailFetchedState(Resource.loading())) {
    on<RegisterStoredEvent>(
      _onRegisterStored,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicRepository _topicRepository;

  late int topicId;

  Future<void> _onRegisterStored(
    RegisterStoredEvent event,
    Emitter<RegisterDetailState> emit,
  ) async {
    emit(RegisterDetailStoredState(Resource.loading()));

    var result = await _topicRepository.registerTopic(
      topicId: topicId,
    );

    emit(RegisterDetailStoredState(result));
  }

  void registerTopic() {
    add(RegisterStoredEvent());
  }
}
