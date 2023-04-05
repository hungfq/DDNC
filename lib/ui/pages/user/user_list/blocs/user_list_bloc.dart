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
    on<UserListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
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

  Future<void> _onRefreshed(
    UserListRefreshedEvent event,
    Emitter<UserListState> emit,
  ) async {
    var result = await _userRepository.listUser();
    if (result.state == Result.success) {
      _getListUserResult = _getListUserResult.copyWith(
        data: ListUserResponse(
          result.data?.data ?? [],
          _getListUserResult.data!.meta,
        ),
      );
    }
    emit(UserListRefreshedState(result));
  }

  void refresh() {
    add(const UserListRefreshedEvent());
  }

  //region actions
  void fetch() {
    add(const UserListFetchedEvent());
  }

  void loadMore() {
    add(const UserListLoadMoreEvent());
  }
}
