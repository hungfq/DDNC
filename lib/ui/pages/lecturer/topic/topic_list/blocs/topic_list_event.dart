abstract class LecturerTopicListEvent {
  const LecturerTopicListEvent();
}

class LecturerTopicListFetchedEvent extends LecturerTopicListEvent {
  const LecturerTopicListFetchedEvent();
}

class LecturerTopicListLoadMoreEvent extends LecturerTopicListEvent {
  const LecturerTopicListLoadMoreEvent();
}

class LecturerTopicListRefreshedEvent extends LecturerTopicListEvent {
  const LecturerTopicListRefreshedEvent();
}

class LecturerTopicListSearchedEvent extends LecturerTopicListEvent {
  const LecturerTopicListSearchedEvent();
}

class LecturerTopicListDataChangedEvent extends LecturerTopicListEvent {
  const LecturerTopicListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
