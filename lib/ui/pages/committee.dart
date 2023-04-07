import 'package:flutter/material.dart';

class UserSelector {
  final int id;
  final String name;

  UserSelector({required this.id, required this.name});
}

final List<UserSelector> users = [
  UserSelector(id: 1, name: 'User 1'),
  UserSelector(id: 2, name: 'User 2'),
  UserSelector(id: 3, name: 'User 3'),
];

// Committee model
class Committee {
  final int id;
  final String code;
  final String name;
  final int presidentId;
  final int secretaryId;
  final int criticalId;

  Committee({
    required this.id,
    required this.code,
    required this.name,
    required this.presidentId,
    required this.secretaryId,
    required this.criticalId,
  });
}

// UI for Committee List
class CommitteeListPage extends StatelessWidget {
  final List<Committee> committees = [
    Committee(
      id: 1,
      code: 'COM-001',
      name: 'Committee 1',
      presidentId: 1,
      secretaryId: 2,
      criticalId: 3,
    ),
    Committee(
      id: 2,
      code: 'COM-002',
      name: 'Committee 2',
      presidentId: 4,
      secretaryId: 5,
      criticalId: 6,
    ),
    Committee(
      id: 3,
      code: 'COM-003',
      name: 'Committee 3',
      presidentId: 7,
      secretaryId: 8,
      criticalId: 9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committee List'),
      ),
      body: ListView.builder(
        itemCount: committees.length,
        itemBuilder: (context, index) {
          final committee = committees[index];
          return Card(
            child: ListTile(
              title: Text(committee.name),
              subtitle: Text('Code: ${committee.code}'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => _navigateToDetailsPage(context, committee),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToAddPage(context),
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context, Committee committee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommitteeDetailsPage(committee: committee),
      ),
    );
  }

  void _navigateToAddPage(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => AddCommitteePage(),
    //   ),
    // );
  }
}

// UI for Committee Details Page
class CommitteeDetailsPage extends StatefulWidget {
  final Committee committee;
  final Function(Committee)? onUpdate;
  final Function(Committee)? onRemove;

  CommitteeDetailsPage({required this.committee, this.onUpdate, this.onRemove});

  @override
  _CommitteeDetailsPageState createState() => _CommitteeDetailsPageState();
}

class _CommitteeDetailsPageState extends State<CommitteeDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _presidentIdController;
  late TextEditingController _secretaryIdController;
  late TextEditingController _criticalIdController;
  late Committee committee;

  @override
  void initState() {
    super.initState();
    committee = widget.committee;
    _nameController = TextEditingController(text: widget.committee.name);
    _codeController = TextEditingController(text: widget.committee.code);
    _presidentIdController =
        TextEditingController(text: widget.committee.presidentId.toString());
    _secretaryIdController =
        TextEditingController(text: widget.committee.secretaryId.toString());
    _criticalIdController =
        TextEditingController(text: widget.committee.criticalId.toString());
  }

  void _updateCommittee(Committee updatedCommittee) {
    setState(() {
      // _committee = updatedCommittee;
    });
  }

  void _removeCommittee() {
    // remove committee from the database or API
    Navigator.pop(context, committee.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              committee.code,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'President ID:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButton<int>(
              value: committee.presidentId,
              onChanged: (value) {},
              items: users.map((user) {
                return DropdownMenuItem<int>(
                  value: user.id,
                  child: Text(user.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Secretary ID:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButton<int>(
              value: committee.secretaryId,
              onChanged: (value) {},
              items: users.map((user) {
                return DropdownMenuItem<int>(
                  value: user.id,
                  child: Text(user.name),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Critical ID:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButton<int>(
              value: committee.criticalId,
              onChanged: (value) {},
              items: users.map((user) {
                return DropdownMenuItem<int>(
                  value: user.id,
                  child: Text(user.name),
                );
              }).toList(),
            ),
            SizedBox(height: 32.0),
            Row(
              children: [
                ElevatedButton(
                  child: Text('Edit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommitteeFormPage(committee: committee),
                      ),
                    );
                  },
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  child: Text('Delete'),
                  onPressed: () {
                    // TODO: Implement delete functionality
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommitteeFormPage extends StatefulWidget {
  final Committee? committee;

  CommitteeFormPage({this.committee});

  @override
  _CommitteeFormPageState createState() => _CommitteeFormPageState();
}

class _CommitteeFormPageState extends State<CommitteeFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _nameController;
  late TextEditingController _presidentIdController;
  late TextEditingController _secretaryIdController;
  late TextEditingController _criticalIdController;

  @override
  void initState() {
    super.initState();

    _codeController = TextEditingController(text: widget.committee?.code ?? '');
    _nameController = TextEditingController(text: widget.committee?.name ?? '');
    _presidentIdController = TextEditingController(
        text: widget.committee?.presidentId?.toString() ?? '');
    _secretaryIdController = TextEditingController(
        text: widget.committee?.secretaryId?.toString() ?? '');
    _criticalIdController = TextEditingController(
        text: widget.committee?.criticalId?.toString() ?? '');
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _presidentIdController.dispose();
    _secretaryIdController.dispose();
    _criticalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.committee == null ? 'Create Committee' : 'Edit Committee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _presidentIdController,
                decoration: InputDecoration(labelText: 'President ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a president ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _secretaryIdController,
                decoration: InputDecoration(labelText: 'Secretary ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a secretary ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _criticalIdController,
                decoration: InputDecoration(labelText: 'Critical ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a critical ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text(widget.committee == null ? 'Create' : 'Update'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final committee = Committee(
                          id: widget.committee!.id,
                          code: _codeController.text,
                          name: _nameController.text,
                          presidentId: int.parse(_presidentIdController.text),
                          secretaryId: int.parse(_secretaryIdController.text),
                          criticalId: int.parse(_criticalIdController.text),
                        );
                        if (widget.committee == null) {
                          // widget.onCreate(committee);
                        } else {
                          // widget.onUpdate(committee);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  if (widget.committee != null) SizedBox(width: 16.0),
                  ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      // widget.onDelete(widget.committee!);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
