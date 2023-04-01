import 'package:ddnc_new/ui/admin_page/topic_section/schedule_selection.dart';
import 'package:ddnc_new/ui/admin_page/topic_section/student_selection_page.dart';
import 'package:ddnc_new/ui/admin_page/topic_section/topic_model.dart';
import 'package:flutter/material.dart';

class TopicEditPage extends StatefulWidget {
  final Topic topic;

  TopicEditPage({required this.topic});

  @override
  _TopicEditPageState createState() => _TopicEditPageState();
}

class _TopicEditPageState extends State<TopicEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentsController = TextEditingController();
  final _scheduleController = TextEditingController();
  String _lectureId = '';
  String _title = '';
  int _limit = 0;
  String _description = '';
  List<String> _selectedStudents = [];

  @override
  void initState() {
    super.initState();
    _lectureId = widget.topic.lectureId.toString();
    _title = widget.topic.title;
    _limit = widget.topic.limit;
    _description = widget.topic.description;
    _selectedStudents = widget.topic.students;
    _studentsController.text = _selectedStudents.join(', ');
    _scheduleController.text = widget.topic.schedule;
  }

  @override
  void dispose() {
    _studentsController.dispose();
    _scheduleController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      Topic updatedTopic = Topic(
        code: widget.topic.code,
        title: _title,
        description: _description,
        lectureId: int.parse(_lectureId),
        limit: _limit,
        criticalLecturerId: widget.topic.criticalLecturerId,
        students: _selectedStudents,
        schedule: _scheduleController.text,
        advisorLecturerGrade: widget.topic.advisorLecturerGrade,
        committeePresidentGrade: widget.topic.committeePresidentGrade,
        committeeSecretaryLecturer: widget.topic.committeeSecretaryLecturer,
      );
      print(updatedTopic);
      // TODO: Save updatedTopic to database or backend
      Navigator.pop(context, updatedTopic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code: ${widget.topic.code}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _title = value!;
                    });
                  },

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: widget.topic.limit.toString(),
                  decoration: InputDecoration(
                    labelText: 'Limit',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a limit for the topic';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _limit = int.parse(value!);
                  },
                  onChanged: (value) {
                    setState(() {
                      _limit = int.parse(value!);
                    });

                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _lectureId,
                  decoration: InputDecoration(
                    labelText: 'Lecture',
                    border: OutlineInputBorder(),
                  ),
                  items: ['1', '2', '3', '4', '5']
                      .map((value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text('Lecture $value'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _lectureId = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a lecture';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _studentsController,
                  decoration: InputDecoration(
                    labelText: 'Students',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<String> allStudents = [
                      'Alice',
                      'Bob',
                      'Charlie',
                      'Dave',
                      'Eve'
                    ];
                    List<String> _selectedStudents = ['Alice', 'Dave'];

                    final newSelectedStudents = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentSelectionPage(
                          allStudents: allStudents,
                          selectedStudents: _selectedStudents,
                        ),
                      ),
                    );

                    if (newSelectedStudents != null) {
                      setState(() {
                        _selectedStudents = newSelectedStudents;
                        _studentsController.text = _selectedStudents.join(', ');
                      });
                    }
                  },
                  validator: (value) {
                    if (_selectedStudents.isEmpty) {
                      return 'Please select at least one student';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _scheduleController,
                  decoration: InputDecoration(
                    labelText: 'Schedule',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final selectedSchedule = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleSelectionPage(
                          selectedSchedule: widget.topic.schedule,
                        ),
                      ),
                    );
                    if (selectedSchedule != null) {
                      setState(() {
                        _scheduleController.text = selectedSchedule;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a schedule';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _saveChanges();
                  },
                  child: Text('Apply'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
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
