import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_result_event.dart';
import 'register_result_state.dart';

class RegisterResultBloc
    extends Bloc<RegisterResultEvent, RegisterResultState> {
  RegisterResultBloc({
    required TopicRepository topicRepository,
  })  : _topicRepository = topicRepository,
        super(RegisterTopicListFetchedState(Resource.loading())) {
    on<RegisterTopicListFetchedEvent>(
      _onTopicFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<RegisterTopicListLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<RegisterTopicListRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicRepository _topicRepository;
  Resource<ListTopicResponse> _getListRegisterTopicResult = Resource.loading();

  Resource<ListTopicResponse> get getListRegisterTopicResult =>
      _getListRegisterTopicResult;

  int get currentPage =>
      _getListRegisterTopicResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage =>
      _getListRegisterTopicResult.data?.meta.pagination.totalPage ?? 1;

  List<TopicInfo> get topicList => _getListRegisterTopicResult.data?.data ?? [];

  Future<void> _onTopicFetched(
    RegisterTopicListFetchedEvent event,
    Emitter<RegisterResultState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    RegisterTopicListRefreshedEvent event,
    Emitter<RegisterResultState> emit,
  ) async {
    var result = await _topicRepository.listRegisterResult(
      1,
      currentPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getListRegisterTopicResult = _getListRegisterTopicResult.copyWith(
        data: ListTopicResponse(
          result.data?.data ?? [],
          _getListRegisterTopicResult.data!.meta,
        ),
      );
    }
    emit(RegisterTopicListRefreshedState(result));
  }

  Future<void> _onLoadMore(
    RegisterTopicListLoadMoreEvent event,
    Emitter<RegisterResultState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(RegisterTopicListLoadMoreState(_getListRegisterTopicResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _topicRepository.listRegisterResult(nextPage);
      if (result.state == Result.success) {
        _getListRegisterTopicResult = _getListRegisterTopicResult.copyWith(
          data: ListTopicResponse(
            [
              ...topicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(RegisterTopicListLoadMoreState(result));
    }
  }

  void fetch() {
    add(const RegisterTopicListFetchedEvent());
  }

  void loadMore() {
    add(const RegisterTopicListLoadMoreEvent());
  }

  void _fetch(Emitter<RegisterResultState> emit) async {
    emit(RegisterTopicListFetchedState(Resource.loading()));

    var result = await _topicRepository.listRegisterResult();
    _getListRegisterTopicResult = result;

    emit(RegisterTopicListFetchedState(_getListRegisterTopicResult));
  }
}
