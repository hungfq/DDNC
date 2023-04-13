import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class ScheduleListState {
  const ScheduleListState();
}

class ScheduleListFetchedState extends ScheduleListState {
  const ScheduleListFetchedState(this.resource);

  final Resource<ListScheduleResponse> resource;
}

class ScheduleListLoadMoreState extends ScheduleListState {
  const ScheduleListLoadMoreState(this.resource);

  final Resource<ListScheduleResponse> resource;
}

class ScheduleListRefreshedState extends ScheduleListState {
  const ScheduleListRefreshedState(this.resource);

  final Resource<ListScheduleResponse> resource;
}
