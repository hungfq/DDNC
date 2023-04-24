abstract class ApproveProposalListEvent {
  const ApproveProposalListEvent();
}

class ApproveProposalListFetchedEvent extends ApproveProposalListEvent {
  const ApproveProposalListFetchedEvent();
}

class ApproveProposalListLoadMoreEvent extends ApproveProposalListEvent {
  const ApproveProposalListLoadMoreEvent();
}

class ApproveProposalListRefreshedEvent extends ApproveProposalListEvent {
  const ApproveProposalListRefreshedEvent();
}

class ApproveProposalListSearchedEvent extends ApproveProposalListEvent {
  const ApproveProposalListSearchedEvent();
}

class ApproveProposalListDataChangedEvent extends ApproveProposalListEvent {
  const ApproveProposalListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
