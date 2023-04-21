import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class RegisterResultState {
  const RegisterResultState();
}
class RegisterTopicListFetchedState extends RegisterResultState {
  const RegisterTopicListFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListLoadMoreState extends RegisterResultState {
  const RegisterTopicListLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListRefreshedState extends RegisterResultState {
  const RegisterTopicListRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListDataChangedState extends RegisterResultState {
  const RegisterTopicListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}
