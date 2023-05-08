import 'package:ddnc_new/api/request/mark_topic_request.dart';

abstract class LecturerMarkEvent {
  const LecturerMarkEvent();
}

class LecturerTopicFetchedEvent extends LecturerMarkEvent {
  const LecturerTopicFetchedEvent();
}

class LecturerTopicLoadMoreEvent extends LecturerMarkEvent {
  const LecturerTopicLoadMoreEvent();
}

class LecturerTopicRefreshedEvent extends LecturerMarkEvent {
  const LecturerTopicRefreshedEvent();
}

class LecturerMarkedEvent extends LecturerMarkEvent {
  const LecturerMarkedEvent(this.topicId, this.request);

  final int topicId;
  final MarkTopicRequest request;
}
