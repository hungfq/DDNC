import 'package:ddnc_new/api/response/list_schedule_response.dart';
import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/user_selection_one_with_id_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/user_selection_multi_with_code_page.dart';
import '../../../admin/topic/topic_detail/components/schedule_selection_one_with_id_page.dart';
import '../proposal_list/components/proposal_list_view.dart';
import 'blocs/proposal_detail_bloc.dart';

class TopicProposalDetailPage extends StatefulWidget {
  const TopicProposalDetailPage({Key? key}) : super(key: key);

  @override
  State<TopicProposalDetailPage> createState() =>
      _TopicProposalDetailPageState();
}

class _TopicProposalDetailPageState extends State<TopicProposalDetailPage>
    with BasePageState {
  late String ACTION = "EDIT";
  late TopicProposalDetailBloc _topicDetailBloc;
  final _formKey = GlobalKey<FormState>();
  final _lecturerController = TextEditingController();
  final _studentsController = TextEditingController();
  final _scheduleController = TextEditingController();
  late int _id;
  late String _code;
  late String _title;
  late String? _description;
  late int? _limit;
  late int? _scheduleId;
  late ModelSimple? _schedule;
  late int? _lecturerId;
  late ModelSimple? _lecturer;
  late List<String> _students = [];

  @override
  Future<void> pageInitState() async {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _topicDetailBloc = context.read<TopicProposalDetailBloc>();
    ACTION = arguments[TopicProposalListView.topicAction];

    _id = arguments[TopicProposalListView.topic].id;
    _code = arguments[TopicProposalListView.topic].code ?? "";
    _title = arguments[TopicProposalListView.topic].title ?? "";
    _description = arguments[TopicProposalListView.topic].description ?? "";
    _limit = arguments[TopicProposalListView.topic].limit ?? 0;
    _scheduleId = arguments[TopicProposalListView.topic].schedule?.id;
    _schedule = arguments[TopicProposalListView.topic].schedule;
    _lecturerId = arguments[TopicProposalListView.topic].lecturer?.id;
    _lecturer = arguments[TopicProposalListView.topic].lecturer;
    _students = arguments[TopicProposalListView.topic].studentCode ?? [];

    _lecturerController.text = "${_lecturer?.code} - ${_lecturer?.name}";
    _studentsController.text = _students.join(', ');
    _scheduleController.text = "${_schedule?.code} - ${_schedule?.name}";
    super.pageInitState();
  }

  @override
  void dispose() {
    _lecturerController.dispose();
    _studentsController.dispose();
    _scheduleController.dispose();
    super.dispose();
  }

  void _createTopic() {
    if (_formKey.currentState!.validate()) {
      _topicDetailBloc.createTopicProposal(
        code: _code,
        title: _title,
        description: _description!,
        limit: _limit!,
        scheduleId: _scheduleId,
        lecturerId: _lecturerId,
        students: _students,
      );
      Navigator.pop(context);
    }
  }

  void _updateTopic() {
    if (_formKey.currentState!.validate()) {
      _topicDetailBloc.topicId = _id;
      _topicDetailBloc.updateTopicProposal(
        code: _code,
        title: _title,
        description: _description!,
        limit: _limit!,
        scheduleId: _scheduleId,
        lecturerId: _lecturerId,
        students: _students,
      );
      Navigator.pop(context);
    }
  }

  void _deleteTopic() {
    if (_formKey.currentState!.validate()) {
      _topicDetailBloc.topicId = _id;
      _topicDetailBloc.deleteTopicProposal();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Topic'),
        iconTheme: IconThemeData(
          color: theme.colorScheme.onPrimary,
        ),
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

                    final newSelected = await Navigator.push(
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
                    if (_scheduleId == null) {
                      return 'Please select Schedule';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    if (ACTION == 'EDIT') ...[
                      ElevatedButton(
                        onPressed: _updateTopic,
                        child: Text('Update Proposal'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Delete"),
                                content: const Text(
                                    "Are you sure you want to delete this proposal?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Delete"),
                                    onPressed: () {
                                      _deleteTopic();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Delete Proposal'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      )
                    ] else ... [
                      ElevatedButton(
                        onPressed: _createTopic,
                        child: Text('Create Proposal'),
                      )
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
