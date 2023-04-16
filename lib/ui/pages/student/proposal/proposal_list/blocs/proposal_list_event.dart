abstract class TopicProposalListEvent {
  const TopicProposalListEvent();
}

class TopicProposalListFetchedEvent extends TopicProposalListEvent {
  const TopicProposalListFetchedEvent();
}

class TopicProposalListLoadMoreEvent extends TopicProposalListEvent {
  const TopicProposalListLoadMoreEvent();
}

class TopicProposalListRefreshedEvent extends TopicProposalListEvent {
  const TopicProposalListRefreshedEvent();
}

class TopicProposalListSearchedEvent extends TopicProposalListEvent {
  const TopicProposalListSearchedEvent();
}

class TopicProposalListDataChangedEvent extends TopicProposalListEvent {
  const TopicProposalListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
