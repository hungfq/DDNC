import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:flutter/material.dart';

class ScheduleSelectionOneWithIdPage extends StatefulWidget {
  late int? selectedScheduleId;
  late ModelSimple? selectedSchedule;
  late List<ScheduleInfo> allSchedules;
  late String pageTitle = "Schedule";

  ScheduleSelectionOneWithIdPage(
      {required this.selectedScheduleId,
      required this.selectedSchedule,
      required this.allSchedules,
      required this.pageTitle});

  @override
  _ScheduleSelectionOneWithIdPageState createState() =>
      _ScheduleSelectionOneWithIdPageState();
}

class _ScheduleSelectionOneWithIdPageState
    extends State<ScheduleSelectionOneWithIdPage> {
  late List<ScheduleInfo> _filteredSchedule;
  late TextEditingController _searchController;

  @override
  void initState() {
    _filteredSchedule = widget.allSchedules;
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
      _filteredSchedule = widget.allSchedules
          .where(
              (model) => model.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onStudentSelected(ScheduleInfo model) {
    setState(() {
      widget.selectedSchedule = ModelSimple(model.id, model.code, model.name);
      widget.selectedScheduleId = model.id;
    });
  }

  void _saveSelection() {
    Navigator.pop(context, widget.selectedSchedule);
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
              itemCount: _filteredSchedule.length,
              itemBuilder: (context, index) {
                final model = _filteredSchedule[index];
                final isSelected = widget.selectedScheduleId == model.id;
                return ListTile(
                  title: Text("${model.code} - ${model.name}"),
                  trailing: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onStudentSelected(model),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
