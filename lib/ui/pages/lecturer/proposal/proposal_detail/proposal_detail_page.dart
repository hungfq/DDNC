import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:ddnc_new/api/response/result.dart';
import 'package:ddnc_new/commons/helpers.dart';
import 'package:ddnc_new/ui/base/base_page_state.dart';
import 'package:ddnc_new/ui/dialogs/loading_dialog.dart';
import 'package:ddnc_new/ui/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../proposal_list/components/proposal_list_view.dart';
import 'blocs/proposal_detail_bloc.dart';
import 'blocs/proposal_detail_state.dart';

class ApproveProposalDetailPage extends StatefulWidget {
  const ApproveProposalDetailPage({Key? key}) : super(key: key);

  @override
  State<ApproveProposalDetailPage> createState() =>
      _ApproveProposalDetailPageState();
}

class _ApproveProposalDetailPageState extends State<ApproveProposalDetailPage>
    with BasePageState {
  late String ACTION = "EDIT";
  late ApproveProposalDetailBloc _topicDetailBloc;
  final _formKey = GlobalKey<FormState>();
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
    _topicDetailBloc = context.read<ApproveProposalDetailBloc>();
    ACTION = arguments[ApproveProposalListView.topicAction];

    _id = arguments[ApproveProposalListView.topic].id;
    _code = arguments[ApproveProposalListView.topic].code ?? "";
    _title = arguments[ApproveProposalListView.topic].title ?? "";
    _description = arguments[ApproveProposalListView.topic].description ?? "";
    _limit = arguments[ApproveProposalListView.topic].limit ?? 0;
    _scheduleId = arguments[ApproveProposalListView.topic].schedule?.id;
    _schedule = arguments[ApproveProposalListView.topic].schedule;
    _lecturerId = arguments[ApproveProposalListView.topic].lecturer?.id;
    _lecturer = arguments[ApproveProposalListView.topic].lecturer;
    _students = arguments[ApproveProposalListView.topic].studentCode ?? [];

    super.pageInitState();
  }

  void _approveTopic() {
    _topicDetailBloc.topicId = _id;
    _topicDetailBloc.lecturerApproveProposal();

    Navigator.pop(context);
  }

  void _declineTopic() {
    _topicDetailBloc.topicId = _id;
    _topicDetailBloc.lecturerDeclineProposal();

    Navigator.pop(context);
  }

  void _handleListeners(
      BuildContext context, ApproveProposalDetailState state) {
    if (state is TopicProposalApprovedState) {
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
    if (state is TopicProposalDeclinedState) {
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
    return BlocListener<ApproveProposalDetailBloc, ApproveProposalDetailState>(
        listener: _handleListeners,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('View Proposal'),
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
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      readOnly: true,
                      initialValue: "${_lecturer?.code} - ${_lecturer?.name}",
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
                      initialValue: "${_schedule?.code} - ${_schedule?.name}",
                      decoration: const InputDecoration(
                        labelText: 'Schedule',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _approveTopic,
                          child: Text('Approve Proposal'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: _declineTopic,
                          child: Text('Decline Proposal'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
