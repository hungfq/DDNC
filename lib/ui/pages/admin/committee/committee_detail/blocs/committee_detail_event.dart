import 'package:ddnc_new/api/request/update_committee_request.dart';

abstract class CommitteeDetailEvent {
  const CommitteeDetailEvent();
}

class CommitteeDetailFetchedEvent extends CommitteeDetailEvent {
  const CommitteeDetailFetchedEvent();
}

class CommitteeCreatedEvent extends CommitteeDetailEvent {
  const CommitteeCreatedEvent(this.request);

  final UpdateCommitteeRequest request;
}

class CommitteeUpdatedEvent extends CommitteeDetailEvent {
  const CommitteeUpdatedEvent(this.request);

  final UpdateCommitteeRequest request;
}

class CommitteeDeletedEvent extends CommitteeDetailEvent {
  const CommitteeDeletedEvent();
}
