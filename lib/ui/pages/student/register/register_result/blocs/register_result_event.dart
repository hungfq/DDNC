abstract class RegisterResultEvent {
  const RegisterResultEvent();
}

class RegisterTopicListFetchedEvent extends RegisterResultEvent {
  const RegisterTopicListFetchedEvent();
}

class RegisterTopicListLoadMoreEvent extends RegisterResultEvent {
  const RegisterTopicListLoadMoreEvent();
}

class RegisterTopicListRefreshedEvent extends RegisterResultEvent {
  const RegisterTopicListRefreshedEvent();
}

class RegisterTopicListSearchedEvent extends RegisterResultEvent {
  const RegisterTopicListSearchedEvent();
}

class RegisterTopicListDataChangedEvent extends RegisterResultEvent {
  const RegisterTopicListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
