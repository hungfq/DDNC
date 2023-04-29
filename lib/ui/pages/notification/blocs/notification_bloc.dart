import 'package:ddnc_new/api/response/list_notification_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(NotificationFetchedState(Resource.loading())) {
    on<NotificationFetchedEvent>(
      _onFetched,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<NotificationLoadMoreEvent>(
      _onLoadMore,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<NotificationRefreshedEvent>(
      _onRefreshed,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<NotificationReadEvent>(
      _onNotificationRead,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<NotificationDeletedEvent>(
      _onNotificationDeleted,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final NotificationRepository _notificationRepository;
  Resource<ListNotificationResponse> _getListNotificationResult =
      Resource.loading();

  //region getters & setters

  Resource<ListNotificationResponse> get getListTopicResult =>
      _getListNotificationResult;

  int get currentPage =>
      _getListNotificationResult.data?.meta.pagination.currentPage ?? 1;

  int get totalPage =>
      _getListNotificationResult.data?.meta.pagination.totalPage ?? 1;

  List<NotificationInfo> get topicList =>
      _getListNotificationResult.data?.data ?? [];

  Future<void> _onFetched(
    NotificationFetchedEvent event,
    Emitter<NotificationState> emit,
  ) async =>
      _fetch(emit);

  Future<void> _onRefreshed(
    NotificationRefreshedEvent event,
    Emitter<NotificationState> emit,
  ) async {
    var result = await _notificationRepository.listNotification(
      1,
      currentPage * Constants.itemPerPage,
    );
    if (result.state == Result.success) {
      _getListNotificationResult = _getListNotificationResult.copyWith(
        data: ListNotificationResponse(
          result.data?.data ?? [],
          _getListNotificationResult.data!.meta,
        ),
      );
    }
    emit(NotificationRefreshedState(result));
  }

  Future<void> _onLoadMore(
    NotificationLoadMoreEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (currentPage == totalPage) {
      emit(NotificationLoadMoreState(_getListNotificationResult));
    } else {
      var nextPage = currentPage + 1;

      var result = await _notificationRepository.listNotification(nextPage);
      if (result.state == Result.success) {
        _getListNotificationResult = _getListNotificationResult.copyWith(
          data: ListNotificationResponse(
            [
              ...topicList,
              ...result.data?.data ?? [],
            ],
            result.data!.meta,
          ),
        );
      }
      emit(NotificationLoadMoreState(result));
    }
  }

  Future<void> _onNotificationRead(
    NotificationReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationReadState(Resource.loading()));

    var result = await _notificationRepository.readNotification(
        notificationId: event.notificationId);
    emit(NotificationReadState(result));
  }

  Future<void> _onNotificationDeleted(
    NotificationDeletedEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationDeletedState(Resource.loading()));

    var result = await _notificationRepository.deleteNotification(
        notificationId: event.notificationId);
    emit(NotificationDeletedState(result));
  }

  //region actions
  void fetch() {
    add(const NotificationFetchedEvent());
  }

  void loadMore() {
    add(const NotificationLoadMoreEvent());
  }

  void readNotification(int notificationId) {
    add(NotificationReadEvent(notificationId));
  }

  void deleteNotification(int notificationId) {
    add(NotificationDeletedEvent(notificationId));
  }

  void _fetch(Emitter<NotificationState> emit) async {
    emit(NotificationFetchedState(Resource.loading()));

    var result = await _notificationRepository.listNotification();
    _getListNotificationResult = result;

    emit(NotificationFetchedState(_getListNotificationResult));
  }
}
