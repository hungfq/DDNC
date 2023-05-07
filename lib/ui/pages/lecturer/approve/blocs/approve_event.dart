abstract class LecturerApproveEvent {
  const LecturerApproveEvent();
}

class LecturerAdvisorTopicFetchedEvent extends LecturerApproveEvent {
  const LecturerAdvisorTopicFetchedEvent();
}

class LecturerCriticalTopicFetchedEvent extends LecturerApproveEvent {
  const LecturerCriticalTopicFetchedEvent();
}

class LecturerAdvisorTopicLoadMoreEvent extends LecturerApproveEvent {
  const LecturerAdvisorTopicLoadMoreEvent();
}

class LecturerCriticalTopicLoadMoreEvent extends LecturerApproveEvent {
  const LecturerCriticalTopicLoadMoreEvent();
}

class LecturerAdvisorTopicRefreshedEvent extends LecturerApproveEvent {
  const LecturerAdvisorTopicRefreshedEvent();
}

class LecturerCriticalTopicRefreshedEvent extends LecturerApproveEvent {
  const LecturerCriticalTopicRefreshedEvent();
}

class LecturerAdvisorApprovedEvent extends LecturerApproveEvent {
  const LecturerAdvisorApprovedEvent(this.topicId);

  final int topicId;
}

class LecturerCriticalApprovedEvent extends LecturerApproveEvent {
  const LecturerCriticalApprovedEvent(this.topicId);

  final int topicId;
}

class LecturerAdvisorDeclinedEvent extends LecturerApproveEvent {
  const LecturerAdvisorDeclinedEvent(this.topicId);

  final int topicId;
}

class LecturerCriticalDeclinedEvent extends LecturerApproveEvent {
  const LecturerCriticalDeclinedEvent(this.topicId);

  final int topicId;
}
