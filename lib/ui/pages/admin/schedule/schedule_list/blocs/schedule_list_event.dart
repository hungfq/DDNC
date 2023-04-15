abstract class ScheduleListEvent {
  const ScheduleListEvent();
}

class ScheduleListFetchedEvent extends ScheduleListEvent {
  const ScheduleListFetchedEvent();
}

class ScheduleListLoadMoreEvent extends ScheduleListEvent {
  const ScheduleListLoadMoreEvent();
}

class ScheduleListRefreshedEvent extends ScheduleListEvent {
  const ScheduleListRefreshedEvent();
}

class ScheduleListSearchedEvent extends ScheduleListEvent {
  const ScheduleListSearchedEvent();
}

class ScheduleListDataChangedEvent extends ScheduleListEvent {
  const ScheduleListDataChangedEvent(this.event, [this.data]);

  final String event;
  final dynamic data;

  static const keywordChanged = "keyword_changed";
}
