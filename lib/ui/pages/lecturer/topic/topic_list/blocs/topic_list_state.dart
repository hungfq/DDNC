import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class LecturerTopicListState {
  const LecturerTopicListState();
}

class LecturerTopicListFetchedState extends LecturerTopicListState {
  const LecturerTopicListFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerTopicListLoadMoreState extends LecturerTopicListState {
  const LecturerTopicListLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerTopicListRefreshedState extends LecturerTopicListState {
  const LecturerTopicListRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerTopicListDataChangedState extends LecturerTopicListState {
  const LecturerTopicListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}