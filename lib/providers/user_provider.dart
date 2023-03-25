import 'package:ddnc_new/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> setUser(UserModel user) async {
    this._user = user;
    notifyListeners();
  }
}
