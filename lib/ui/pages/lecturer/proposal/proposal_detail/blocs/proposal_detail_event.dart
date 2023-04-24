abstract class ApproveProposalDetailEvent {
  const ApproveProposalDetailEvent();
}

class ApproveProposalApprovedEvent extends ApproveProposalDetailEvent {
  const ApproveProposalApprovedEvent();
}

class ApproveProposalDeclinedEvent extends ApproveProposalDetailEvent {
  const ApproveProposalDeclinedEvent();
}