import 'package:ddnc_new/api/response/list_committee_response.dart';
import 'package:ddnc_new/api/response/resource.dart';

abstract class CommitteeListState {
  const CommitteeListState();
}

class CommitteeListFetchedState extends CommitteeListState {
  const CommitteeListFetchedState(this.resource);

  final Resource<ListCommitteeResponse> resource;
}

class CommitteeListLoadMoreState extends CommitteeListState {
  const CommitteeListLoadMoreState(this.resource);

  final Resource<ListCommitteeResponse> resource;
}

class CommitteeListRefreshedState extends CommitteeListState {
  const CommitteeListRefreshedState(this.resource);

  final Resource<ListCommitteeResponse> resource;
}

class CommitteeListDataChangedState extends CommitteeListState {
  const CommitteeListDataChangedState(this.event, [this.data]);

  final String event;
  final dynamic data;
}
