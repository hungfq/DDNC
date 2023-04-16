import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/components/user_selection_one_with_id_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../committee_list/components/committee_list_view.dart';
import 'blocs/committee_detail_bloc.dart';

class CommitteeDetailPage extends StatefulWidget {
  const CommitteeDetailPage({Key? key}) : super(key: key);

  @override
  State<CommitteeDetailPage> createState() => _CommitteeDetailPageState();
}

class _CommitteeDetailPageState extends State<CommitteeDetailPage>
    with BasePageState {
  late String ACTION = "EDIT";
  late CommitteeDetailBloc _committeeDetailBloc;
  final _formKey = GlobalKey<FormState>();
  final _presidentController = TextEditingController();
  final _secretaryController = TextEditingController();
  final _criticalController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  late int? _id;
  late String? _code;
  late String? _name;
  late ModelSimple? _committeePresident;
  late int? _committeePresidentId;
  late ModelSimple? _committeeSecretary;
  late int? _committeeSecretaryId;
  late ModelSimple? _criticalLecturer;
  late int? _criticalLecturerId;
  late List _topics = [];

  @override
  void pageInitState() {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _committeeDetailBloc = context.read<CommitteeDetailBloc>();
    ACTION = arguments[CommitteeListView.committeeAction];

    _id = arguments[CommitteeListView.committee].id ?? 0;
    _code = arguments[CommitteeListView.committee].code ?? "";
    _name = arguments[CommitteeListView.committee].name ?? "";
    _committeePresident =
        arguments[CommitteeListView.committee].committeePresident;
    _committeePresidentId =
        arguments[CommitteeListView.committee].committeePresident?.id;
    _committeeSecretary =
        arguments[CommitteeListView.committee].committeeSecretary;
    _committeeSecretaryId =
        arguments[CommitteeListView.committee].committeeSecretary?.id;
    _criticalLecturer = arguments[CommitteeListView.committee].criticalLecturer;
    _criticalLecturerId =
        arguments[CommitteeListView.committee].criticalLecturer?.id;
    _topics = arguments[CommitteeListView.committee].topics ?? [];

    _presidentController.text =
        "${_committeePresident?.code} - ${_committeePresident?.name}";
    _secretaryController.text =
        "${_committeeSecretary?.code} - ${_committeeSecretary?.name}";
    _criticalController.text =
        "${_criticalLecturer?.code} - ${_criticalLecturer?.name}";
    super.pageInitState();
  }

  void _createCommittee() {
    if (_formKey.currentState!.validate()) {
      _committeeDetailBloc.createCommittee(
          code: _code ?? "",
          name: _name ?? "",
          committeePresidentId: _committeePresidentId,
          committeeSecretaryId: _committeeSecretaryId,
          criticalLecturerId: _criticalLecturerId,
          topics: _topics);
      Navigator.pop(context);
    }
  }

  void _updateCommittee() {
    if (_formKey.currentState!.validate()) {
      _committeeDetailBloc.committeeId = _id ?? 0;
      _committeeDetailBloc.updateCommittee(
          code: _code ?? "",
          name: _name ?? "",
          committeePresidentId: _committeePresidentId,
          committeeSecretaryId: _committeeSecretaryId,
          criticalLecturerId: _criticalLecturerId,
          topics: _topics);
      Navigator.pop(context);
    }
  }

  void _deleteCommittee() {
    if (_formKey.currentState!.validate()) {
      _committeeDetailBloc.committeeId = _id ?? 0;
      _committeeDetailBloc.deleteCommittee();
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _presidentController.dispose();
    _secretaryController.dispose();
    _criticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committee'),
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
                    if (value!.isEmpty) {
                      return 'Please enter a code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _code = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _code = value;
                    });
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
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _presidentController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'President',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> allPresident = await _committeeDetailBloc
                        .forceFetchUser("", "LECTURER");

                    final newSelectedLecturer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionOneWithIdPage(
                          selectedUserId: _committeePresidentId,
                          selectedUser: _committeePresident,
                          allUsers: allPresident,
                          pageTitle: 'President',
                        ),
                      ),
                    );

                    if (newSelectedLecturer != null) {
                      setState(() {
                        _presidentController.text =
                            "${newSelectedLecturer.code} - ${newSelectedLecturer.name}";
                      });
                      _committeePresident = newSelectedLecturer;
                      _committeePresidentId = newSelectedLecturer.id;
                    }
                  },
                  validator: (value) {
                    if (_committeePresidentId == null) {
                      return 'Please select lecturer';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _secretaryController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Secretary',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> all = await _committeeDetailBloc
                        .forceFetchUser("", "LECTURER");

                    final newSelectedLecturer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionOneWithIdPage(
                          selectedUserId: _committeeSecretaryId,
                          selectedUser: _committeeSecretary,
                          allUsers: all,
                          pageTitle: 'Secretary',
                        ),
                      ),
                    );

                    if (newSelectedLecturer != null) {
                      setState(() {
                        _secretaryController.text =
                            "${newSelectedLecturer.code} - ${newSelectedLecturer.name}";
                      });
                      _committeeSecretary = newSelectedLecturer;
                      _committeeSecretaryId = newSelectedLecturer.id;
                    }
                  },
                  validator: (value) {
                    if (_committeePresidentId == null) {
                      return 'Please select lecturer';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _criticalController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Critical',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    List<UserInfo> all = await _committeeDetailBloc
                        .forceFetchUser("", "LECTURER");

                    final newSelectedLecturer = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionOneWithIdPage(
                          selectedUserId: _criticalLecturerId,
                          selectedUser: _criticalLecturer,
                          allUsers: all,
                          pageTitle: 'Critical',
                        ),
                      ),
                    );

                    if (newSelectedLecturer != null) {
                      setState(() {
                        _criticalController.text =
                            "${newSelectedLecturer.code} - ${newSelectedLecturer.name}";
                      });
                      _criticalLecturer = newSelectedLecturer;
                      _criticalLecturerId = newSelectedLecturer.id;
                    }
                  },
                  validator: (value) {
                    if (_criticalLecturerId == null) {
                      return 'Please select Critical';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    if (ACTION == 'EDIT') ...[
                      ElevatedButton(
                        onPressed: _updateCommittee,
                        child: Text('Update Committee'),
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
                                    "Are you sure you want to delete this committee?"),
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
                                      _deleteCommittee();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Delete Committee'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      )
                    ] else ...[
                      ElevatedButton(
                        onPressed: _createCommittee,
                        child: Text('Create Committee'),
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
