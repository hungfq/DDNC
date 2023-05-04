import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/user_selection_multi_with_code_page.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import '../schedule_detail/blocs/schedule_detail_bloc.dart';
import '../schedule_list/components/schedule_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'blocs/schedule_detail_state.dart';

class ScheduleDetailPage extends StatefulWidget {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage>
    with BasePageState {
  late String ACTION = "EDIT";
  late ScheduleDetailBloc _scheduleDetailBloc;
  final _formKey = GlobalKey<FormState>();
  final _studentsController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  late int? _id;
  late String? _code;
  late String? _name;
  late String? _description;
  late String? _startDate;
  late String? _deadline;
  late String? _startProposalDate;
  late String? _endProposalDate;
  late String? _startApproveDate;
  late String? _endApproveDate;
  late String? _startRegisterDate;
  late String? _endRegisterDate;
  late List<String> _students = [];

  @override
  void pageInitState() {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _scheduleDetailBloc = context.read<ScheduleDetailBloc>();
    ACTION = arguments[ScheduleListView.scheduleAction];

    _id = arguments[ScheduleListView.schedule].id ?? 0;
    _code = arguments[ScheduleListView.schedule].code ?? "";
    _name = arguments[ScheduleListView.schedule].name ?? "";
    _description = arguments[ScheduleListView.schedule].description;
    _startDate = arguments[ScheduleListView.schedule].startDate;
    _deadline = arguments[ScheduleListView.schedule].deadline;
    _startProposalDate = arguments[ScheduleListView.schedule].startProposalDate;
    _endProposalDate = arguments[ScheduleListView.schedule].endProposalDate;
    _startApproveDate = arguments[ScheduleListView.schedule].startApproveDate;
    _endApproveDate = arguments[ScheduleListView.schedule].endApproveDate;
    _startRegisterDate = arguments[ScheduleListView.schedule].startRegisterDate;
    _endRegisterDate = arguments[ScheduleListView.schedule].endRegisterDate;
    _students = arguments[ScheduleListView.schedule].students ?? [];
    _studentsController.text = _students.join(', ');
    super.pageInitState();
  }

  @override
  void dispose() {
    _studentsController.dispose();
    super.dispose();
  }

  void _createSchedule() {
    if (_formKey.currentState!.validate()) {
      _scheduleDetailBloc.createSchedule(
          code: _code ?? "",
          name: _name ?? "",
          description: _description,
          startDate: _startDate,
          deadline: _deadline,
          startProposalDate: _startProposalDate,
          endProposalDate: _endProposalDate,
          startApproveDate: _startApproveDate,
          endApproveDate: _endApproveDate,
          startRegisterDate: _startRegisterDate,
          endRegisterDate: _endRegisterDate,
          students: _students);
      Navigator.pop(context);
    }
  }

  void _updateSchedule() {
    if (_formKey.currentState!.validate()) {
      _scheduleDetailBloc.scheduleId = _id ?? 0;
      _scheduleDetailBloc.updateSchedule(
          code: _code ?? "",
          name: _name ?? "",
          description: _description,
          startDate: _startDate,
          deadline: _deadline,
          startProposalDate: _startProposalDate,
          endProposalDate: _endProposalDate,
          startApproveDate: _startApproveDate,
          endApproveDate: _endApproveDate,
          startRegisterDate: _startRegisterDate,
          endRegisterDate: _endRegisterDate,
          students: _students);
      Navigator.pop(context);
    }
  }

  void _deleteSchedule() {
    if (_formKey.currentState!.validate()) {
      _scheduleDetailBloc.scheduleId = _id ?? 0;
      _scheduleDetailBloc.deleteSchedule();
      Navigator.pop(context);
    }
  }

  void _handleListeners(BuildContext context, ScheduleDetailState state) {
    if (state is ScheduleCreatedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          LoadingDialog.show(context);
          break;
        case Result.error:
          LoadingDialog.hide(context);

          Helpers.showErrorDialog(context: context, resource: resource);
          break;
        case Result.success:
          LoadingDialog.hide(context);

          SuccessDialog.show(
            context: context,
            msg: resource.data ?? "",
          );
          break;
      }

      return;
    }

    if (state is ScheduleUpdatedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          LoadingDialog.show(context);
          break;
        case Result.error:
          LoadingDialog.hide(context);

          Helpers.showErrorDialog(context: context, resource: resource);
          break;
        case Result.success:
          LoadingDialog.hide(context);

          SuccessDialog.show(
            context: context,
            msg: resource.data ?? "",
          );
          break;
      }

      return;
    }

    if (state is ScheduleDeletedState) {
      var resource = state.resource;

      switch (resource.state) {
        case Result.loading:
          LoadingDialog.show(context);
          break;
        case Result.error:
          LoadingDialog.hide(context);

          Helpers.showErrorDialog(context: context, resource: resource);
          break;
        case Result.success:
          LoadingDialog.hide(context);

          SuccessDialog.show(
            context: context,
            msg: resource.data ?? "",
          );
          break;
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleDetailBloc, ScheduleDetailState>(
      listener: _handleListeners,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Schedule'),
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
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _code,
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a code';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _code = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'Start Date',
                    DateTime.parse(_startDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _startDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'Deadline',
                    DateTime.parse(_deadline ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _deadline = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'Start Proposal Date',
                    DateTime.parse(_startProposalDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _startProposalDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'End Proposal Date',
                    DateTime.parse(_endProposalDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _endProposalDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'Start Approve Date',
                    DateTime.parse(_startApproveDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _startApproveDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'End Approve Date',
                    DateTime.parse(_endApproveDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _endApproveDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'Start Register Date',
                    DateTime.parse(_startRegisterDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _startRegisterDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  MyBuildDateInput(
                    context,
                    'End Register Date',
                    DateTime.parse(_endRegisterDate ?? "2022-01-01 00:00:00"),
                    (DateTime date) {
                      setState(() {
                        _endRegisterDate = _dateFormat.format(date);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _studentsController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Students',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      List<UserInfo> allStudents = await _scheduleDetailBloc
                          .forceFetchUser("", "STUDENT");

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
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      if (ACTION == 'EDIT') ...[
                        ElevatedButton(
                          onPressed: _updateSchedule,
                          child: Text('Update'),
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
                                      "Are you sure you want to delete this schedule?"),
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
                                        _deleteSchedule();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        )
                      ] else ...[
                        ElevatedButton(
                          onPressed: _createSchedule,
                          child: Text('Create'),
                        )
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MyBuildDateInput(BuildContext context, String label, DateTime value,
      ValueChanged<DateTime> onChanged) {
    return InkWell(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2022),
          lastDate: DateTime(2030),
        ).then((date) {
          if (date != null) {
            onChanged(date);
          }
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_dateFormat.format(value)),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
