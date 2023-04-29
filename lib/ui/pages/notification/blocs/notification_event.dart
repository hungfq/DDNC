abstract class NotificationEvent {
  const NotificationEvent();
}

class NotificationFetchedEvent extends NotificationEvent {
  const NotificationFetchedEvent();
}

class NotificationLoadMoreEvent extends NotificationEvent {
  const NotificationLoadMoreEvent();
}

class NotificationRefreshedEvent extends NotificationEvent {
  const NotificationRefreshedEvent();
}

class NotificationReadEvent extends NotificationEvent {
  const NotificationReadEvent(this.notificationId);

  final int notificationId;
}

class NotificationDeletedEvent extends NotificationEvent {
  const NotificationDeletedEvent(this.notificationId);

  final int notificationId;
}
