import 'package:ddnc_new/api/request/update_topic_request.dart';

abstract class TopicDetailEvent {
  const TopicDetailEvent();
}

class TopicUpdatedEvent extends TopicDetailEvent {
  const TopicUpdatedEvent(this.request);

  final UpdateTopicRequest request;
}

class UsersFetchedEvent extends TopicDetailEvent {
  UsersFetchedEvent(this.search, this.type);

  final String search;
  final String type;
}
