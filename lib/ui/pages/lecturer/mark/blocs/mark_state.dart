import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class LecturerMarkState {
  const LecturerMarkState();
}

class LecturerTopicFetchedState extends LecturerMarkState {
  const LecturerTopicFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerTopicLoadMoreState extends LecturerMarkState {
  const LecturerTopicLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerTopicRefreshedState extends LecturerMarkState {
  const LecturerTopicRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerMarkedState extends LecturerMarkState {
  const LecturerMarkedState(this.resource);

  final Resource<String> resource;
}
