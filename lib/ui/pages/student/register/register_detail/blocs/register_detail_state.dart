import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class RegisterDetailState {
  const RegisterDetailState();
}

class RegisterDetailFetchedState extends RegisterDetailState {
  const RegisterDetailFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterDetailStoredState extends RegisterDetailState {
  const RegisterDetailStoredState(this.resource);

  final Resource<String> resource;
}
