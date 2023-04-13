import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/material.dart';

class UserSelectionOneWithIdPage extends StatefulWidget {
  late int? selectedUserId;
  late ModelSimple? selectedUser;
  late List<UserInfo> allUsers;
  late String pageTitle = "User";

  UserSelectionOneWithIdPage(
      {required this.selectedUserId,
      required this.selectedUser,
      required this.allUsers,
      required this.pageTitle});

  @override
  _UserSelectionOneWithIdPageState createState() =>
      _UserSelectionOneWithIdPageState();
}

class _UserSelectionOneWithIdPageState
    extends State<UserSelectionOneWithIdPage> {
  late List<UserInfo> _filteredUser;
  late TextEditingController _searchController;

  @override
  void initState() {
    _filteredUser = widget.allUsers;
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredUser = widget.allUsers
          .where(
              (user) => user.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onStudentSelected(UserInfo user) {
    setState(() {
      // if (widget.selectedUserId.contains(user)) {
      //   widget.selectedUserId.remove(user);
      // } else {
      //   widget.selectedUserId.add(user);
      // }
      widget.selectedUser = ModelSimple(user.id, user.code, user.name);
      widget.selectedUserId = user.id;
    });
  }

  void _saveSelection() {
    Navigator.pop(context, widget.selectedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.pageTitle}'),
        actions: [
          TextButton(
            onPressed: _saveSelection,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ${widget.pageTitle}',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUser.length,
              itemBuilder: (context, index) {
                final user = _filteredUser[index];
                final isSelected = widget.selectedUserId == user.id;
                return ListTile(
                  title: Text("${user.code} - ${user.name}"),
                  trailing: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onStudentSelected(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
