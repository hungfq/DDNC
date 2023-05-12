import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import 'package:ddnc_new/ui/pages/student/register/register_detail/blocs/register_detail_state.dart';
import 'package:ddnc_new/ui/pages/student/register/register_list/components/register_list_view.dart';
import 'blocs/register_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterDetailPage extends StatefulWidget {
  const RegisterDetailPage({Key? key}) : super(key: key);

  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage>
    with BasePageState {
  late String ACTION = "REGISTER";
  late RegisterDetailBloc _registerDetailBloc;
  late int _id;
  late String _code;
  late String _title;
  late String? _description;
  late int? _limit;
  late ModelSimple? _schedule;
  late ModelSimple? _lecturer;
  late List<String> _students = [];
  late double? _advisorLecturerGrade;
  late double? _criticalLecturerGrade;
  late double? _committeePresidentGrade;
  late double? _committeeSecretaryGrade;

  @override
  Future<void> pageInitState() async {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _registerDetailBloc = context.read<RegisterDetailBloc>();
    ACTION = arguments[RegisterListView.topicAction];

    _id = arguments[RegisterListView.topic].id;
    _code = arguments[RegisterListView.topic].code ?? "";
    _title = arguments[RegisterListView.topic].title ?? "";
    _description = arguments[RegisterListView.topic].description ?? "";
    _limit = arguments[RegisterListView.topic].limit;
    _schedule = arguments[RegisterListView.topic].schedule;
    _lecturer = arguments[RegisterListView.topic].lecturer;
    _students = arguments[RegisterListView.topic].studentCode ?? [];
    _advisorLecturerGrade =
        arguments[RegisterListView.topic].advisorLecturerGrade;
    _criticalLecturerGrade =
        arguments[RegisterListView.topic].criticalLecturerGrade;
    _committeePresidentGrade =
        arguments[RegisterListView.topic].committeePresidentGrade;
    _committeeSecretaryGrade =
        arguments[RegisterListView.topic].committeeSecretaryGrade;

    super.pageInitState();
  }

  void _saveRegistration() {
    _registerDetailBloc.topicId = _id;
    _registerDetailBloc.registerTopic();
    Navigator.pop(context);
  }

  void _cancelRegistration() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want unregister this topic?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                _registerDetailBloc.topicId = _id;
                _registerDetailBloc.cancelRegister();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleListeners(BuildContext context, RegisterDetailState state) {
    if (state is RegisterDetailStoredState) {
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
    if (state is RegisterDetailCanceledState) {
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
    return BlocListener<RegisterDetailBloc, RegisterDetailState>(
      listener: _handleListeners,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Topic'),
          iconTheme: IconThemeData(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title ?? "",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Code: ${_code}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Limit: ${_limit}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                const Text(
                  'Lecturer',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                 "${_lecturer?.code ?? ''} - ${_lecturer?.name ?? ''}",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  _description ?? "",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Schedule',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  _schedule?.name ?? "",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Students',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var item in _students ?? []) Text(item)
                  ],
                ),
                SizedBox(height: 20.0),
                const Text(
                  'Grades',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Advisor Lecturer',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _advisorLecturerGrade?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Critical Lecturer',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _criticalLecturerGrade?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Committee President',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _committeePresidentGrade?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Committee Secretary',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _committeeSecretaryGrade?.toString() ?? "",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                if (ACTION == 'REGISTER')
                  ElevatedButton(
                    onPressed: () {
                      _saveRegistration();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text('Registration'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      _cancelRegistration();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text('Cancel Registration'),
                  ),
              ],
              // children: [
              //   TextFormField(
              //     readOnly: true,
              //     initialValue: _code,
              //     decoration: const InputDecoration(
              //       labelText: 'Code',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     initialValue: _title,
              //     decoration: const InputDecoration(
              //       labelText: 'Title',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     maxLines: 3,
              //     initialValue: _description,
              //     decoration: const InputDecoration(
              //       labelText: 'Description',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     initialValue: _limit.toString(),
              //     decoration: const InputDecoration(
              //       labelText: 'Limit',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     initialValue:
              //         " ${_lecturer?.code.toString()} -  ${_lecturer?.name}",
              //     decoration: const InputDecoration(
              //       labelText: 'Lecturer',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     initialValue: _students.join(', '),
              //     decoration: const InputDecoration(
              //       labelText: 'Students',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   TextFormField(
              //     readOnly: true,
              //     initialValue:
              //         "${_schedule?.code.toString()} - ${_schedule?.name.toString()}",
              //     decoration: const InputDecoration(
              //       labelText: 'Schedule',
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              //   const SizedBox(height: 16.0),
              //   if (ACTION == 'REGISTER')
              //     ElevatedButton(
              //       onPressed: () {
              //         _saveRegistration();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.green,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 16.0,
              //           vertical: 12.0,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(16.0),
              //         ),
              //       ),
              //       child: const Text('Registration'),
              //     )
              //   else
              //     ElevatedButton(
              //       onPressed: () {
              //         _cancelRegistration();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.red,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 16.0,
              //           vertical: 12.0,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(16.0),
              //         ),
              //       ),
              //       child: const Text('Cancel Registration'),
              //     ),
              // ],
            ),
          ),
        ),
      ),
    );
  }
}
