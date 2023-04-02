import 'package:ddnc_new/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountInfo extends ChangeNotifier {
  UserModel? _accountInfo;

  set accountInfo(UserModel? value) {
    _accountInfo = value;
    notifyListeners();
  }

  UserModel? get accountInfo => _accountInfo;

  static AccountInfo of(BuildContext context) => Provider.of<AccountInfo>(
        context,
        listen: false,
      );
}
