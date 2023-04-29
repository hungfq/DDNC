import 'package:ddnc_new/api/response/list_notification_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationFetchedState extends NotificationState {
  const NotificationFetchedState(this.resource);

  final Resource<ListNotificationResponse> resource;
}

class NotificationLoadMoreState extends NotificationState {
  const NotificationLoadMoreState(this.resource);

  final Resource<ListNotificationResponse> resource;
}

class NotificationRefreshedState extends NotificationState {
  const NotificationRefreshedState(this.resource);

  final Resource<ListNotificationResponse> resource;
}

class NotificationReadState extends NotificationState {
  const NotificationReadState(this.resource);

  final Resource<String> resource;
}

class NotificationDeletedState extends NotificationState {
  const NotificationDeletedState(this.resource);

  final Resource<String> resource;
}