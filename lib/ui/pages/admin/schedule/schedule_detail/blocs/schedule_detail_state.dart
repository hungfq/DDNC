import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class ScheduleDetailState {
  const ScheduleDetailState();
}

class ScheduleDetailFetchedState extends ScheduleDetailState {
  const ScheduleDetailFetchedState(this.resource);

  final Resource<ListScheduleResponse> resource;
}

class ScheduleCreatedState extends ScheduleDetailState {
  const ScheduleCreatedState(this.resource);

  final Resource<String> resource;
}

class ScheduleUpdatedState extends ScheduleDetailState {
  const ScheduleUpdatedState(this.resource);

  final Resource<String> resource;
}

class ScheduleDeletedState extends ScheduleDetailState {
  const ScheduleDeletedState(this.resource);

  final Resource<String> resource;
}
