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

class UserListSearchedEvent extends UserListEvent {
  const UserListSearchedEvent();
}

class UserListDataChangedEvent extends UserListEvent {
  const UserListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
