import 'package:ddnc_new/api/response/list_stats_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(StatsFetchedState(Resource.loading())) {
    on<StatsFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final UserRepository _userRepository;
  Resource<ListStatsResponse> _getListStatsResult = Resource.loading();

  Resource<ListStatsResponse> get getListUserResult => _getListStatsResult;

  List<StatsInfo> get advisorStats =>
      _getListStatsResult.data?.advisorStats ?? [];

  List<StatsInfo> get genderStats =>
      _getListStatsResult.data?.genderStats ?? [];

  Future<void> _onFetched(
    StatsFetchedEvent event,
    Emitter<StatsState> emit,
  ) async =>
      _fetch(emit);

  void fetch() {
    add(const StatsFetchedEvent());
  }

  void _fetch(Emitter<StatsState> emit) async {
    emit(StatsFetchedState(Resource.loading()));

    var result = await _userRepository.listStats();
    _getListStatsResult = result;

    emit(StatsFetchedState(_getListStatsResult));
  }
}
