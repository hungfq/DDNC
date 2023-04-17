abstract class RegisterListEvent {
  const RegisterListEvent();
}

class RegisterScheduleListFetchedEvent extends RegisterListEvent {
  const RegisterScheduleListFetchedEvent();
}

class RegisterTopicListFetchedEvent extends RegisterListEvent {
  const RegisterTopicListFetchedEvent();
}

class RegisterTopicListLoadMoreEvent extends RegisterListEvent {
  const RegisterTopicListLoadMoreEvent();
}

class RegisterTopicListRefreshedEvent extends RegisterListEvent {
  const RegisterTopicListRefreshedEvent();
}

class RegisterTopicListSearchedEvent extends RegisterListEvent {
  const RegisterTopicListSearchedEvent();
}

class RegisterTopicListDataChangedEvent extends RegisterListEvent {
  const RegisterTopicListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
