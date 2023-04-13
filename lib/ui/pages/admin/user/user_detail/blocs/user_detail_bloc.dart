import 'package:ddnc_new/api/request/update_user_request.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  UserDetailBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserDetailFetchedState(Resource.loading())) {
    on<UserUpdatedEvent>(
      _onUserUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final UserRepository _userRepository;
  late int userId;

  Future<void> _onUserUpdated(
    UserUpdatedEvent event,
    Emitter<UserDetailState> emit,
  ) async {
    emit(UserUpdatedState(Resource.loading()));

    var result = await _userRepository.updateUser(
      userId: userId,
      request: event.request,
    );

    emit(UserUpdatedState(result));
  }

  void updateUser(
      {required String code,
      required String name,
      required String email,
      required String gender,
      required String status}) {
    add(UserUpdatedEvent(UpdateUserRequest(code, name, email, gender, status)));
  }
}
