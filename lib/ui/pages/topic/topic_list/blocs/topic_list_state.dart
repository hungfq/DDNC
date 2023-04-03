import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class TopicListState {
  const TopicListState();
}

class TopicListFetchedState extends TopicListState {
  const TopicListFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class TopicListLoadMoreState extends TopicListState {
  const TopicListLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class TopicListRefreshedState extends TopicListState {
  const TopicListRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}
