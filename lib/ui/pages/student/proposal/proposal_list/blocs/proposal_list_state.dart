import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class TopicProposalListState {
  const TopicProposalListState();
}

class TopicProposalListFetchedState extends TopicProposalListState {
  const TopicProposalListFetchedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class TopicProposalListLoadMoreState extends TopicProposalListState {
  const TopicProposalListLoadMoreState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class TopicProposalListRefreshedState extends TopicProposalListState {
  const TopicProposalListRefreshedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class TopicProposalListDataChangedState extends TopicProposalListState {
  const TopicProposalListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}