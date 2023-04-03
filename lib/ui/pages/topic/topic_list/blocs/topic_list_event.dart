abstract class TopicListEvent {
  const TopicListEvent();
}

class TopicListFetchedEvent extends TopicListEvent {
  const TopicListFetchedEvent();
}

class TopicListLoadMoreEvent extends TopicListEvent {
  const TopicListLoadMoreEvent();
}

class TopicListRefreshedEvent extends TopicListEvent {
  const TopicListRefreshedEvent();
}