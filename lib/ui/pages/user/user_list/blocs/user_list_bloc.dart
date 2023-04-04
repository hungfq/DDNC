import 'package:ddnc_new/api/request/update_user_request.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserListFetchedState(Resource.loading())) {
    on<UserListFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<UserListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<UserUpdatedEvent>(
      _onUserUpdated,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    // on<UserListRefreshedEvent>(
    //   _onRefreshed,
    //   transformer: throttleDroppable(Constants.throttleDuration),
    // );
  }

  final UserRepository _userRepository;
  late int userId;
  Resource<ListUserResponse> _getListUserResult = Resource.loading();

  Resource<ListUserResponse> get getListUserResult => _getListUserResult;

  int get currentPage =>
      _getListUserResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage => _getListUserResult.data?.meta.pagination.totalPage ?? 1;

  List<UserInfo> get userList => _getListUserResult.data?.data ?? [];

  Future<void> _onFetched(
    UserListFetchedEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(UserListFetchedState(Resource.loading()));

    var result = await _userRepository.listUser();
    _getListUserResult = result;

    emit(UserListFetchedState(_getListUserResult));
  }

  Future<void> _onLoadMore(
    UserListLoadMoreEvent event,
    Emitter<UserListState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(UserListLoadMoreState(_getListUserResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _userRepository.listUser(nextPage);
      if (result.state == Result.success) {
        _getListUserResult = _getListUserResult.copyWith(
          data: ListUserResponse(
            [
              ...userList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(UserListLoadMoreState(result));
    }
  }

  Future<void> _onUserUpdated(
    UserUpdatedEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(UserUpdatedState(Resource.loading()));

    var result = await _userRepository.updateUser(
      userId: userId,
      request: event.request,
    );

    if (result.state == Result.success) {
      fetch();
    }

    emit(UserUpdatedState(result));
  }

  //region actions
  void fetch() {
    add(const UserListFetchedEvent());
  }

  void loadMore() {
    add(const UserListLoadMoreEvent());
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
