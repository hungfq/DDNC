import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/material.dart';

class StudentSelectionPage extends StatefulWidget {
  final List<String> selectedStudents;
  final List<UserInfo> allStudents;

  StudentSelectionPage({
    required this.selectedStudents,
    required this.allStudents,
  });

  @override
  _StudentSelectionPageState createState() => _StudentSelectionPageState();
}

class _StudentSelectionPageState extends State<StudentSelectionPage> {
  late List<UserInfo> _filteredStudents;
  late TextEditingController _searchController;

  @override
  void initState() {
    _filteredStudents = widget.allStudents;
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
      _filteredStudents = widget.allStudents
          .where((student) =>
              student.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onStudentSelected(String student) {
    setState(() {
      if (widget.selectedStudents.contains(student)) {
        widget.selectedStudents.remove(student);
      } else {
        widget.selectedStudents.add(student);
      }
    });
  }

  void _saveSelection() {
    Navigator.pop(context, widget.selectedStudents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Students'),
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
              decoration: const InputDecoration(
                hintText: 'Search students',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredStudents.length,
              itemBuilder: (context, index) {
                final student = _filteredStudents[index];
                final isSelected =
                    widget.selectedStudents.contains(student.code);
                return ListTile(
                  title: Text(student.code),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onStudentSelected(student.code),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
