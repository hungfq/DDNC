import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_bloc.dart';
import 'package:ddnc_new/ui/pages/user/user_list/blocs/user_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditPage extends StatefulWidget {
  final UserInfo user;

  UserEditPage({required this.user});

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  // late UserListBloc _userListBloc;

  final _formKey = GlobalKey<FormState>();
  late int _id;
  late String _code;
  late String _name;
  late String _email;
  late String _gender;
  late String _status;

  // late String _address;

  @override
  void initState() {
    // _userListBloc = context.read<UserListBloc>();
    // _userListBloc.userId = widget.user.id;
    super.initState();
    _id = widget.user.id;
    _code = widget.user.code ?? "";
    _name = widget.user.name ?? "";
    _email = widget.user.email ?? "";
    _gender = widget.user.gender ?? "";
    _status = widget.user.status ?? "";
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'id': _id,
        'name': _name,
        'email': _email,
        'code': _code,
        'gender': _gender,
        'status': _status
      });
    }
  }

  void _handleListeners(BuildContext context, UserListState state) {
    if (state is UserUpdatedState) {
      var resource = state.resource;
      switch (resource.state) {
        case Result.loading:
          break;
        case Result.error:
          break;
        case Result.success:
          // _userListBloc.fetch();
          break;
        default:
          break;
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
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
    );
  }
}
