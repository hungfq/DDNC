abstract class CommitteeListEvent {
  const CommitteeListEvent();
}

class CommitteeListFetchedEvent extends CommitteeListEvent {
  const CommitteeListFetchedEvent();
}

class CommitteeListLoadMoreEvent extends CommitteeListEvent {
  const CommitteeListLoadMoreEvent();
}

class CommitteeListRefreshedEvent extends CommitteeListEvent {
  const CommitteeListRefreshedEvent();
}

class CommitteeListSearchedEvent extends CommitteeListEvent {
  const CommitteeListSearchedEvent();
}

class CommitteeListDataChangedEvent extends CommitteeListEvent {
  const CommitteeListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
