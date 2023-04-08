import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/blocs/topic_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/components/schedule_selection.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/components/student_selection.dart';
import 'package:ddnc_new/ui/pages/topic/topic_list/components/topic_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicDetailPage extends StatefulWidget {
  const TopicDetailPage({Key? key}) : super(key: key);

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> with BasePageState {
  late TopicDetailBloc _topicDetailBloc;
  final _formKey = GlobalKey<FormState>();
  final _studentsController = TextEditingController();
  final _scheduleController = TextEditingController();
  late int _id;
  late String _code;
  late String _title;
  late String _description;
  late int _limit;
  late String _thesisDefenseDate;
  late int _scheduleId;
  late int _lecturerId;
  late int _criticalLecturerId;
  late double _advisorLecturerGrade;
  late double _criticalLecturerGrade;
  late double _committeePresidentGrade;
  late double _committeeSecretaryGrade;
  late List<String> _students;
  late List<UserInfo> _lecturers = [];

  @override
  Future<void> pageInitState() async {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _topicDetailBloc = context.read<TopicDetailBloc>();
    _id = arguments[TopicListView.topic].id;
    _code = arguments[TopicListView.topic].code ?? "";
    _title = arguments[TopicListView.topic].title ?? "";
    _description = arguments[TopicListView.topic].description ?? "";
    _limit = arguments[TopicListView.topic].limit;
    _thesisDefenseDate = arguments[TopicListView.topic].thesisDefenseDate ?? "";
    _scheduleId = arguments[TopicListView.topic].schedule.id;
    _lecturerId = arguments[TopicListView.topic].lecturer.id;
    _criticalLecturerId = arguments[TopicListView.topic].critical.id;
    _advisorLecturerGrade = arguments[TopicListView.topic].advisorLecturerGrade;
    _criticalLecturerGrade =
        arguments[TopicListView.topic].criticalLecturerGrade;
    _committeePresidentGrade =
        arguments[TopicListView.topic].committeePresidentGrade;
    _committeeSecretaryGrade =
        arguments[TopicListView.topic].committeeSecretaryGrade;
    _students = arguments[TopicListView.topic].studentCode ?? [];

    _studentsController.text = _students.join(', ');

    _lecturers = await _topicDetailBloc.forceFetchUser("", "LECTURER");
    super.pageInitState();
  }

  @override
  void dispose() {
    _studentsController.dispose();
    _scheduleController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _topicDetailBloc.topicId = _id;
      _topicDetailBloc.updateTopic(
        code: _code,
        title: _title,
        description: _description,
        limit: _limit,
        thesisDefenseDate: _thesisDefenseDate,
        scheduleId: _scheduleId,
        lecturerId: _lecturerId,
        criticalLecturerId: _criticalLecturerId,
        advisorLecturerGrade: _advisorLecturerGrade,
        criticalLecturerGrade: _criticalLecturerGrade,
        committeePresidentGrade: _committeePresidentGrade,
        committeeSecretaryGrade: _committeeSecretaryGrade,
        students: _students,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code: $_code',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  initialValue: _title,
                  decoration: const InputDecoration(
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
                      _title = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _description,
                  decoration: const InputDecoration(
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
                      _description = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _limit.toString(),
                  decoration: const InputDecoration(
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
                      _limit = int.parse(value);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _lecturerId.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Lecture',
                    border: OutlineInputBorder(),
                  ),
                  items: _lecturers
                      .map((value) => DropdownMenuItem<String>(
                            value: value.id.toString(),
                            child: Text('${value.code} - ${value.name}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _lecturerId = value! as int;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a lecture';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _studentsController,
                  decoration: const InputDecoration(
                    labelText: 'Students',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> allStudents = await _topicDetailBloc.forceFetchUser("", "STUDENT");

                    final newSelectedStudents = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentSelectionPage(
                          allStudents: allStudents,
                          selectedStudents: _students,
                        ),
                      ),
                    );

                    if (newSelectedStudents != null) {
                      setState(() {
                        _studentsController.text = newSelectedStudents.join(', ');
                      });
                    }
                  },
                  validator: (value) {
                    if (_students.isEmpty) {
                      return 'Please select at least one student';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _scheduleController,
                  decoration: const InputDecoration(
                    labelText: 'Schedule',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final selectedSchedule = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleSelectionPage(
                          selectedSchedule: _scheduleId.toString(),
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _saveChanges();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
