import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_list/components/user_list_view.dart';
import 'blocs/user_detail_bloc.dart';
import 'blocs/user_detail_state.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> with BasePageState {
  late UserDetailBloc _userDetailBloc;
  final _formKey = GlobalKey<FormState>();
  late int _id;
  late String _code;
  late String _name;
  late String _email;
  late String _gender;
  late String _status;

  @override
  void pageInitState() {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _userDetailBloc = context.read<UserDetailBloc>();
    _id = arguments[UserListView.user].id;
    _code = arguments[UserListView.user].code ?? "";
    _name = arguments[UserListView.user].name ?? "";
    _email = arguments[UserListView.user].email ?? "";
    _gender = arguments[UserListView.user].gender ?? "";
    _status = arguments[UserListView.user].status ?? "";
    super.pageInitState();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _userDetailBloc.userId = _id;
      _userDetailBloc.updateUser(
          code: _code,
          name: _name,
          email: _email,
          gender: _gender,
          status: _status);
      Navigator.pop(context);
    }
  }

  void _handleListeners(BuildContext context, UserDetailState state) {
    if (state is UserUpdatedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          LoadingDialog.show(context);
          break;
        case Result.error:
          LoadingDialog.hide(context);

          Helpers.showErrorDialog(context: context, resource: resource);
          break;
        case Result.success:
          LoadingDialog.hide(context);

          SuccessDialog.show(
            context: context,
            msg: resource.data ?? "",
          );
          break;
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailBloc, UserDetailState>(
      listener: _handleListeners,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit User'),
          iconTheme: IconThemeData(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _code,
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a code';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _code = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    items: ['male', 'female']
                        .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text('$value'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: ['AC', 'IA']
                        .map((value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text('$value'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a status';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      child: Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
