import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
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
  late RegisterDetailBloc _registerDetailBloc;
  late int _id;
  late String _code;
  late String _title;
  late String? _description;
  late int? _limit;
  late ModelSimple? _schedule;
  late ModelSimple? _lecturer;
  late List<String> _students = [];

  @override
  Future<void> pageInitState() async {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _registerDetailBloc = context.read<RegisterDetailBloc>();
    _id = arguments[RegisterListView.topic].id;
    _code = arguments[RegisterListView.topic].code ?? "";
    _title = arguments[RegisterListView.topic].title ?? "";
    _description = arguments[RegisterListView.topic].description ?? "";
    _limit = arguments[RegisterListView.topic].limit;
        _schedule = arguments[RegisterListView.topic].schedule;
    _lecturer = arguments[RegisterListView.topic].lecturer;
    _students = arguments[RegisterListView.topic].studentCode ?? [];

    super.pageInitState();
  }

  void _saveChanges() {
      _registerDetailBloc.topicId = _id;
      _registerDetailBloc.registerTopic();
      Navigator.pop(context);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: true,
                initialValue: _code,
                decoration: const InputDecoration(
                  labelText: 'Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                readOnly: true,
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                maxLines: 3,
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                initialValue: _limit.toString(),
                decoration: const InputDecoration(
                  labelText: 'Limit',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                initialValue: " ${_lecturer?.code.toString()} -  ${_lecturer?.name}",
                decoration: const InputDecoration(
                  labelText: 'Lecturer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                initialValue: _students.join(', '),
                decoration: const InputDecoration(
                  labelText: 'Students',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                initialValue: "${_schedule?.code.toString()} - ${_schedule?.name.toString()}",
                decoration: const InputDecoration(
                  labelText: 'Schedule',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _saveChanges();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
