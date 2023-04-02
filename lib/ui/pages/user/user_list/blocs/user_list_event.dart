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