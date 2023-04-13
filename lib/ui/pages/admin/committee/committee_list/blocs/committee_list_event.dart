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
