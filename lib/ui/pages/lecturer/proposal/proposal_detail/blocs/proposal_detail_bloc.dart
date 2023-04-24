import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/resource.dart';
import 'package:ddnc_new/commons/constants.dart';
import 'package:ddnc_new/commons/stream_helpers.dart';
import 'package:ddnc_new/repositories/topic_proposal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'proposal_detail_event.dart';
import 'proposal_detail_state.dart';

class ApproveProposalDetailBloc
    extends Bloc<ApproveProposalDetailEvent, ApproveProposalDetailState> {
  ApproveProposalDetailBloc({
    required TopicProposalRepository topicRepository,
  })  : _proposalRepository = topicRepository,
        super(ApproveProposalDetailFetchedState(Resource.loading())) {
    on<ApproveProposalApprovedEvent>(
      _onLecturerApproveProposal,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
    on<ApproveProposalDeclinedEvent>(
      _onLecturerDeclineProposal,
      transformer: throttleDroppable(Constants.throttleDuration),
    );
  }

  final TopicProposalRepository _proposalRepository;

  // final UserRepository _userRepository;
  late int topicId;
  Resource<List<UserInfo>> _userFetchedResult = Resource.loading();

  Resource<List<UserInfo>> get userFetchedResult => _userFetchedResult;

  List<UserInfo> get userList => _userFetchedResult.data ?? [];

  Future<void> _onLecturerApproveProposal(
    ApproveProposalApprovedEvent event,
    Emitter<ApproveProposalDetailState> emit,
  ) async {
    emit(TopicProposalApprovedState(Resource.loading()));

    var result = await _proposalRepository.lecturerApproveProposal(
      topicId: topicId,
    );

    emit(TopicProposalApprovedState(result));
  }

  Future<void> _onLecturerDeclineProposal(
    ApproveProposalDeclinedEvent event,
    Emitter<ApproveProposalDetailState> emit,
  ) async {
    emit(TopicProposalDeclinedState(Resource.loading()));

    var result = await _proposalRepository.lecturerDeclineProposal(
      topicId: topicId,
    );

    emit(TopicProposalDeclinedState(result));
  }

  void lecturerApproveProposal() {
    add(ApproveProposalApprovedEvent());
  }

  void lecturerDeclineProposal() {
    add(ApproveProposalDeclinedEvent());
  }
}
