import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class UserListState {
  const UserListState();
}

class UserListFetchedState extends UserListState {
  const UserListFetchedState(this.resource);

  final Resource<ListUserResponse> resource;
}

class UserListLoadMoreState extends UserListState {
  const UserListLoadMoreState(this.resource);

  final Resource<ListUserResponse> resource;
}

class UserListRefreshedState extends UserListState {
  const UserListRefreshedState(this.resource);

  final Resource<ListUserResponse> resource;
}