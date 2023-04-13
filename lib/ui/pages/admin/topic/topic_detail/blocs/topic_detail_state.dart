import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class TopicDetailState {
  const TopicDetailState();
}

class TopicDetailFetchedState extends TopicDetailState {
  const TopicDetailFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class TopicUpdatedState extends TopicDetailState {
  const TopicUpdatedState(this.resource);

  final Resource<String> resource;
}

class UsersFetchedState extends TopicDetailState {
  const UsersFetchedState(this.resource);

  final Resource<List<UserInfo>> resource;
}
