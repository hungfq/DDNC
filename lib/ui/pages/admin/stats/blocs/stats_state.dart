import 'package:ddnc_new/api/response/list_stats_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class StatsState {
  const StatsState();
}

class StatsFetchedState extends StatsState {
  const StatsFetchedState(this.resource);

  final Resource<ListStatsResponse> resource;
}
