import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class TopicProposalDetailState {
  const TopicProposalDetailState();
}

class TopicProposalDetailFetchedState extends TopicProposalDetailState {
  const TopicProposalDetailFetchedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class TopicProposalCreatedState extends TopicProposalDetailState {
  const TopicProposalCreatedState(this.resource);

  final Resource<String> resource;
}

class TopicProposalUpdatedState extends TopicProposalDetailState {
  const TopicProposalUpdatedState(this.resource);

  final Resource<String> resource;
}

class TopicProposalDeletedState extends TopicProposalDetailState {
  const TopicProposalDeletedState(this.resource);

  final Resource<String> resource;
}

class UsersFetchedState extends TopicProposalDetailState {
  const UsersFetchedState(this.resource);

  final Resource<List<UserInfo>> resource;
}
