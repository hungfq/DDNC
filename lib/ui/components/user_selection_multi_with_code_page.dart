import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/material.dart';

class UserSelectionWithCodePage extends StatefulWidget {
  late List<String> selectedUsers;
  late List<UserInfo> allUsers;
  late String pageTitle = "User";

  UserSelectionWithCodePage(
      {required this.selectedUsers,
      required this.allUsers,
      required this.pageTitle});

  @override
  _UserSelectionWithCodePageState createState() =>
      _UserSelectionWithCodePageState();
}

class _UserSelectionWithCodePageState extends State<UserSelectionWithCodePage> {
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

  void _onStudentSelected(String user) {
    setState(() {
      if (widget.selectedUsers.contains(user)) {
        widget.selectedUsers.remove(user);
      } else {
        widget.selectedUsers.add(user);
      }
    });
  }

  void _saveSelection() {
    Navigator.pop(context, widget.selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.pageTitle}'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
                final isSelected = widget.selectedUsers.contains(user.code);
                return ListTile(
                  title: Text("${user.code} - ${user.name}"),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onStudentSelected(user.code),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
