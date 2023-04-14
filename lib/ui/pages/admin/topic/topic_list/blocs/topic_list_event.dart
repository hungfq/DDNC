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

class TopicListSearchedEvent extends TopicListEvent {
  const TopicListSearchedEvent();
}

class TopicListDataChangedEvent extends TopicListEvent {
  const TopicListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
