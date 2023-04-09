import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/blocs/topic_detail_bloc.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/components/schedule_selection_one_with_id_page.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/components/user_selection_multi_with_code_page.dart';
import 'package:ddnc_new/ui/pages/topic/topic_detail/components/user_selection_one_with_id_page.dart';
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
  final _lecturerController = TextEditingController();
  final _criticalController = TextEditingController();
  final _studentsController = TextEditingController();
  final _scheduleController = TextEditingController();
  late int _id;
  late String _code;
  late String _title;
  late String? _description;
  late int? _limit;
  late String? _thesisDefenseDate;
  late int? _scheduleId;
  late ModelSimple? _schedule;
  late int? _lecturerId;
  late ModelSimple? _lecturer;
  late int? _criticalLecturerId;
  late ModelSimple? _critical;
  late double? _advisorLecturerGrade;
  late double? _criticalLecturerGrade;
  late double? _committeePresidentGrade;
  late double? _committeeSecretaryGrade;
  late List<String> _students = [];

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
    _schedule = arguments[TopicListView.topic].schedule;
    _lecturerId = arguments[TopicListView.topic].lecturer.id;
    _lecturer = arguments[TopicListView.topic].lecturer;
    _criticalLecturerId = arguments[TopicListView.topic].critical.id;
    _critical = arguments[TopicListView.topic].critical;
    _advisorLecturerGrade = arguments[TopicListView.topic].advisorLecturerGrade;
    _criticalLecturerGrade =
        arguments[TopicListView.topic].criticalLecturerGrade;
    _committeePresidentGrade =
        arguments[TopicListView.topic].committeePresidentGrade;
    _committeeSecretaryGrade =
        arguments[TopicListView.topic].committeeSecretaryGrade;
    _students = arguments[TopicListView.topic].studentCode ?? [];

    _lecturerController.text = "${_lecturer?.code} - ${_lecturer?.name}";
    _criticalController.text = "${_critical?.code} - ${_critical?.name}";
    _studentsController.text = _students.join(', ');
    _scheduleController.text = "${_schedule?.code} - ${_schedule?.name}";
    super.pageInitState();
  }

  @override
  void dispose() {
    _lecturerController.dispose();
    _criticalController.dispose();
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
        description: _description!,
        limit: _limit!,
        thesisDefenseDate: _thesisDefenseDate!,
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
                TextFormField(
                  controller: _lecturerController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Lecturer',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> allLecturer =
                        await _topicDetailBloc.forceFetchUser("", "LECTURER");

                    final newSelectedLecturer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionOneWithIdPage(
                          selectedUserId: _lecturerId,
                          selectedUser: _lecturer,
                          allUsers: allLecturer,
                          pageTitle: 'Lecturer',
                        ),
                      ),
                    );

                    if (newSelectedLecturer != null) {
                      setState(() {
                        _lecturerController.text =
                            "${newSelectedLecturer.code} - ${newSelectedLecturer.name}";
                      });
                      _lecturer = newSelectedLecturer;
                      _lecturerId = newSelectedLecturer.id;
                    }
                  },
                  validator: (value) {
                    if (_lecturerId == null) {
                      return 'Please select lecturer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _criticalController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Critical Lecturer',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> allLecturer =
                        await _topicDetailBloc.forceFetchUser("", "LECTURER");

                    final newSelectedLecturer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionOneWithIdPage(
                          selectedUserId: _criticalLecturerId,
                          selectedUser: _critical,
                          allUsers: allLecturer,
                          pageTitle: 'Critical',
                        ),
                      ),
                    );

                    if (newSelectedLecturer != null) {
                      setState(() {
                        _criticalController.text =
                            "${newSelectedLecturer.code} - ${newSelectedLecturer.name}";
                      });
                      _critical = newSelectedLecturer;
                      _criticalLecturerId = newSelectedLecturer.id;
                    }
                  },
                  validator: (value) {
                    if (_critical == null) {
                      return 'Please select Critical lecturer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _studentsController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Students',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> allStudents =
                        await _topicDetailBloc.forceFetchUser("", "STUDENT");

                    final newSelectedStudents = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionWithCodePage(
                          selectedUsers: _students,
                          allUsers: allStudents,
                          pageTitle: 'Student',
                        ),
                      ),
                    );

                    if (newSelectedStudents != null) {
                      setState(() {
                        _studentsController.text =
                            newSelectedStudents.join(', ');
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
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Schedule',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<ScheduleInfo> allSchedule =
                        await _topicDetailBloc.forceFetchSchedule();

                    final newSelected= await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleSelectionOneWithIdPage(
                          pageTitle: 'Schedule',
                          selectedScheduleId: _scheduleId,
                          selectedSchedule: _schedule,
                          allSchedules: allSchedule,
                        ),
                      ),
                    );

                    if (newSelected != null) {
                      setState(() {
                        _scheduleController.text =
                            "${newSelected.code} - ${newSelected.name}";
                      });
                      _schedule = newSelected;
                      _scheduleId = newSelected.id;
                    }
                  },
                  validator: (value) {
                    if (_critical == null) {
                      return 'Please select Schedule';
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
