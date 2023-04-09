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
