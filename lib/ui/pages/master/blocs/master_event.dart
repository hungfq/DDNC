abstract class MasterEvent {
  const MasterEvent();
}

class MasterActionEvent extends MasterEvent {
  const MasterActionEvent(this.action, [this.data]);

  final String action;
  final dynamic data;

  static const signOut = "sign_out";
  static const openDrawer = "open_drawer";
}

class MasterSignOutEvent extends MasterEvent {
  const MasterSignOutEvent();
}

class MasterMenuFetchedEvent extends MasterEvent {
  const MasterMenuFetchedEvent();
}
