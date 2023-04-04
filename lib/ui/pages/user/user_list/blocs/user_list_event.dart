import 'package:ddnc_new/api/request/update_user_request.dart';

abstract class UserListEvent {
  const UserListEvent();
}

class UserListFetchedEvent extends UserListEvent {
  const UserListFetchedEvent();
}

class UserListLoadMoreEvent extends UserListEvent {
  const UserListLoadMoreEvent();
}

class UserListRefreshedEvent extends UserListEvent {
  const UserListRefreshedEvent();
}

class UserUpdatedEvent extends UserListEvent {
  const UserUpdatedEvent(this.request);

  final UpdateUserRequest request;
}
