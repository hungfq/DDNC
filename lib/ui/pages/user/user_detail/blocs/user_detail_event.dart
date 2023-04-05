import 'package:ddnc_new/api/request/update_user_request.dart';

abstract class UserDetailEvent {
  const UserDetailEvent();
}

class UserDetailFetchedEvent extends UserDetailEvent {
  const UserDetailFetchedEvent();
}

class UserUpdatedEvent extends UserDetailEvent {
  const UserUpdatedEvent(this.request);

  final UpdateUserRequest request;
}
