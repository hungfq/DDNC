import 'package:ddnc_new/api/response/list_topic_proposal_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class ApproveProposalDetailState {
  const ApproveProposalDetailState();
}

class ApproveProposalDetailFetchedState extends ApproveProposalDetailState {
  const ApproveProposalDetailFetchedState(this.resource);

  final Resource<ListTopicProposalResponse> resource;
}

class TopicProposalApprovedState extends ApproveProposalDetailState {
  const TopicProposalApprovedState(this.resource);

  final Resource<String> resource;
}

class TopicProposalDeclinedState extends ApproveProposalDetailState {
  const TopicProposalDeclinedState(this.resource);

  final Resource<String> resource;
}