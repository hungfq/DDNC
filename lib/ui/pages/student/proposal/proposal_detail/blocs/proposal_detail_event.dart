import 'package:ddnc_new/api/request/update_topic_proposal_request.dart';

abstract class TopicProposalDetailEvent {
  const TopicProposalDetailEvent();
}

class TopicProposalUpdatedEvent extends TopicProposalDetailEvent {
  const TopicProposalUpdatedEvent(this.request);

  final UpdateTopicProposalRequest request;
}

class TopicProposalCreatedEvent extends TopicProposalDetailEvent {
  const TopicProposalCreatedEvent(this.request);

  final UpdateTopicProposalRequest request;
}

class TopicProposalDeletedEvent extends TopicProposalDetailEvent {
  const TopicProposalDeletedEvent();
}

class UsersFetchedEvent extends TopicProposalDetailEvent {
  UsersFetchedEvent(this.search, this.type);

  final String search;
  final String type;
}


