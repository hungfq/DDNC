import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class UserDetailState {
  const UserDetailState();
}

class UserDetailFetchedState extends UserDetailState {
  const UserDetailFetchedState(this.resource);

  final Resource<ListUserResponse> resource;
}

class UserUpdatedState extends UserDetailState {
  const UserUpdatedState(this.resource);

  final Resource<String> resource;
}
