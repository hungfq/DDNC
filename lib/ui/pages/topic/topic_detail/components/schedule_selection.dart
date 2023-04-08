import 'package:flutter/material.dart';

class ScheduleSelectionPage extends StatefulWidget {
  final String selectedSchedule;

  const ScheduleSelectionPage({super.key, required this.selectedSchedule});

  @override
  _ScheduleSelectionPageState createState() => _ScheduleSelectionPageState();
}

class _ScheduleSelectionPageState extends State<ScheduleSelectionPage> {
  late String _selectedSchedule;

  @override
  void initState() {
    super.initState();
    _selectedSchedule = widget.selectedSchedule;
  }

  void _saveSelection() {
    Navigator.pop(context, _selectedSchedule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Schedule'),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          RadioListTile(
            title: Text('Monday - Friday'),
            value: 'Monday - Friday',
            groupValue: _selectedSchedule,
            onChanged: (value) {
              setState(() {
                _selectedSchedule = value as String;
              });
            },
          ),
          RadioListTile(
            title: Text('Saturday - Sunday'),
            value: 'Saturday - Sunday',
            groupValue: _selectedSchedule,
            onChanged: (value) {
              setState(() {
                _selectedSchedule = value as String;
              });
            },
          ),
        ],
      ),
    );
  }
}
