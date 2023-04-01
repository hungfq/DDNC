import 'package:flutter/material.dart';
class StudentSelectionPage extends StatefulWidget {
  final List<String> selectedStudents;
  final List<String> allStudents;

  StudentSelectionPage({
    required this.selectedStudents,
    required this.allStudents,
  });

  @override
  _StudentSelectionPageState createState() => _StudentSelectionPageState();
}

class _StudentSelectionPageState extends State<StudentSelectionPage> {
  late List<String> _filteredStudents;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredStudents = widget.allStudents;
    _searchController = TextEditingController();
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
          student.toLowerCase().contains(query.toLowerCase()))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
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
                final isSelected = widget.selectedStudents.contains(student);
                return ListTile(
                  title: Text(student),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onStudentSelected(student),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
