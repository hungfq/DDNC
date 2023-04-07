import 'package:ddnc_new/ui/admin_page/user_section/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedule {
  final String id;
  final String name;
  final String code;
  final List<String> students;
  final String description;
  final DateTime startProposalDate;
  final DateTime endProposalDate;
  final DateTime startApproveDate;
  final DateTime endApproveDate;
  final DateTime startRegisterDate;
  final DateTime endRegisterDate;
  final DateTime startDate;
  final DateTime deadline;

  Schedule({
    required this.id,
    required this.name,
    required this.code,
    required this.students,
    required this.description,
    required this.startProposalDate,
    required this.endProposalDate,
    required this.startApproveDate,
    required this.endApproveDate,
    required this.startRegisterDate,
    required this.endRegisterDate,
    required this.startDate,
    required this.deadline,
  });
}

class ScheduleListPage extends StatelessWidget {
  final List<Schedule> schedules;

  ScheduleListPage({required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (BuildContext context, int index) {
          Schedule schedule = schedules[index];
          return Card(
            child: ListTile(
              title: Text(schedule.name),
              subtitle: Text(schedule.code),
              trailing: Text(
                DateFormat('MMM d, yyyy').format(schedule.deadline),
              ),
              onTap: () {
                // TODO: Implement navigation to schedule details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScheduleDetailsPage(schedule: schedule),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:schedule_app/models/schedule.dart';

class ScheduleDetailsPage extends StatefulWidget {
  final Schedule schedule;

  ScheduleDetailsPage({required this.schedule});

  @override
  _ScheduleDetailsPageState createState() => _ScheduleDetailsPageState();
}

class _ScheduleDetailsPageState extends State<ScheduleDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  late DateTime _startProposalDate;
  late DateTime _endProposalDate;
  late DateTime _startApproveDate;
  late DateTime _endApproveDate;
  late DateTime _startRegisterDate;
  late DateTime _endRegisterDate;

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _startProposalDate = widget.schedule.startProposalDate;
      _endProposalDate = widget.schedule.endProposalDate;
      _startApproveDate = widget.schedule.startApproveDate;
      _endApproveDate = widget.schedule.endApproveDate;
      _startRegisterDate = widget.schedule.startRegisterDate;
      _endRegisterDate = widget.schedule.endRegisterDate;
    }
  }

  Widget _buildDateInput(BuildContext context, String label, DateTime value,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.schedule.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.schedule.code,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Start Proposal Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'Start Proposal Date',
                  _startProposalDate,
                  (DateTime date) {
                    setState(() {
                      _startProposalDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'End Proposal Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'End Proposal Date',
                  _endProposalDate,
                  (DateTime date) {
                    setState(() {
                      _endProposalDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Start Approve Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'Start Approve Date',
                  _startApproveDate,
                  (DateTime date) {
                    setState(() {
                      _startApproveDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'End Approve Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'End Approve Date',
                  _endApproveDate,
                  (DateTime date) {
                    setState(() {
                      _endApproveDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Start Register Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'Start Register Date',
                  _startRegisterDate,
                  (DateTime date) {
                    setState(() {
                      _startRegisterDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'End Register Date:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildDateInput(
                  context,
                  'End Register Date',
                  _endRegisterDate,
                  (DateTime date) {
                    setState(() {
                      _endRegisterDate = date;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Deadline:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                // _buildDateInput(
                // context,
                // 'Deadline',
                // _deadline,
                // (DateTime date) {
                // setState(() {
                // _deadline = date;
                // });
                // },
                // ),
                SizedBox(height: 32.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
// _updateSchedule(context);
                    },
                    child: Text('Update Schedule'),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
// _deleteSchedule(context);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Delete Schedule'),
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
