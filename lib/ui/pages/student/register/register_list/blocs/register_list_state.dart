import 'package:ddnc_new/api/response/list_schedule_today_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class RegisterListState {
  const RegisterListState();
}

class RegisterScheduleFetchedState extends RegisterListState {
  const RegisterScheduleFetchedState(this.resource);

  final Resource<ListScheduleTodayResponse> resource;
}

class RegisterTopicListFetchedState extends RegisterListState {
  const RegisterTopicListFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListLoadMoreState extends RegisterListState {
  const RegisterTopicListLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListRefreshedState extends RegisterListState {
  const RegisterTopicListRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class RegisterTopicListDataChangedState extends RegisterListState {
  const RegisterTopicListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}
