import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class LecturerApproveState {
  const LecturerApproveState();
}

class LecturerAdvisorTopicFetchedState extends LecturerApproveState {
  const LecturerAdvisorTopicFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerCriticalTopicFetchedState extends LecturerApproveState {
  const LecturerCriticalTopicFetchedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerAdvisorTopicLoadMoreState extends LecturerApproveState {
  const LecturerAdvisorTopicLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerCriticalTopicLoadMoreState extends LecturerApproveState {
  const LecturerCriticalTopicLoadMoreState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerAdvisorTopicRefreshedState extends LecturerApproveState {
  const LecturerAdvisorTopicRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerCriticalTopicRefreshedState extends LecturerApproveState {
  const LecturerCriticalTopicRefreshedState(this.resource);

  final Resource<ListTopicResponse> resource;
}

class LecturerAdvisorApprovedState extends LecturerApproveState {
  const LecturerAdvisorApprovedState(this.resource);

  final Resource<String> resource;
}

class LecturerCriticalApprovedState extends LecturerApproveState {
  const LecturerCriticalApprovedState(this.resource);

  final Resource<String> resource;
}

class LecturerAdvisorDeclinedState extends LecturerApproveState {
  const LecturerAdvisorDeclinedState(this.resource);

  final Resource<String> resource;
}

class LecturerCriticalDeclinedState extends LecturerApproveState {
  const LecturerCriticalDeclinedState(this.resource);

  final Resource<String> resource;
}
