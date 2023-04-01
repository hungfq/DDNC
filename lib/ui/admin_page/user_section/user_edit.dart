import 'package:ddnc_new/ui/admin_page/user_section/user_model.dart';
import 'package:flutter/material.dart';
class UserEditPage extends StatefulWidget {
  final User user;
  UserEditPage({required this.user});

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phone;
  // late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _email = widget.user.email;
    _phone = widget.user.phone;
    // _address = widget.user.address;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      String name = _name;
      // widget.user.name = _name;
      // widget.user.email = _email;
      // widget.user.phone = _phone;
      // widget.user.address = _address;
      Navigator.pop(context, {'name': _name, 'email': _email, 'phone': _phone});
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                decoration: InputDecoration(
                  labelText: 'Email',
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
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _phone = value;
                },
              ),
              SizedBox(height: 16.0),
              // TextFormField(
              //   initialValue: _address,
              //   decoration: InputDecoration(
              //     labelText: 'Address',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter an address';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     _address = value;
              //   },
              // ),
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
    );
  }
}

