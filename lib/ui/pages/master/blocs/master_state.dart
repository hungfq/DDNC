import 'package:ddnc_new/api/response/resource.dart';

abstract class MasterState {
  const MasterState();
}

class MasterInitState extends MasterState {
  const MasterInitState();
}

class MasterActionState extends MasterState {
  const MasterActionState(this.action, [this.data]);

  final String action;
  final dynamic data;
}

class MasterSignOutState extends MasterState {
  const MasterSignOutState(this.resource);

  final Resource<String> resource;
}

class MasterMenuFetchedState extends MasterState {
  const MasterMenuFetchedState();
}