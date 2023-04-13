import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class CommitteeDetailState {
  const CommitteeDetailState();
}

class CommitteeDetailFetchedState extends CommitteeDetailState {
  const CommitteeDetailFetchedState(this.resource);

  final Resource<ListCommitteeResponse> resource;
}

class CommitteeCreatedState extends CommitteeDetailState {
  const CommitteeCreatedState(this.resource);

  final Resource<String> resource;
}

class CommitteeUpdatedState extends CommitteeDetailState {
  const CommitteeUpdatedState(this.resource);

  final Resource<String> resource;
}

class CommitteeDeletedState extends CommitteeDetailState {
  const CommitteeDeletedState(this.resource);

  final Resource<String> resource;
}
