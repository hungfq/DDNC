import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class ApproveProposalListState {
  const ApproveProposalListState();
}

class ApproveProposalListFetchedState extends ApproveProposalListState {
  const ApproveProposalListFetchedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class ApproveProposalListLoadMoreState extends ApproveProposalListState {
  const ApproveProposalListLoadMoreState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class ApproveProposalListRefreshedState extends ApproveProposalListState {
  const ApproveProposalListRefreshedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class ApproveProposalListDataChangedState extends ApproveProposalListState {
  const ApproveProposalListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}