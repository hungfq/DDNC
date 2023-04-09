import 'package:ddnc_new/api/request/update_schedule_request.dart';

abstract class ScheduleDetailEvent {
  const ScheduleDetailEvent();
}

class ScheduleDetailFetchedEvent extends ScheduleDetailEvent {
  const ScheduleDetailFetchedEvent();
}

class ScheduleCreatedEvent extends ScheduleDetailEvent {
  const ScheduleCreatedEvent(this.request);

  final UpdateScheduleRequest request;
}

class ScheduleUpdatedEvent extends ScheduleDetailEvent {
  const ScheduleUpdatedEvent(this.request);

  final UpdateScheduleRequest request;
}

class ScheduleDeletedEvent extends ScheduleDetailEvent {
  const ScheduleDeletedEvent();
}
