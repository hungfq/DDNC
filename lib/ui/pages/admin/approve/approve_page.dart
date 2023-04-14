import 'package:flutter/material.dart';

class ApprovePage extends StatefulWidget {
  @override
  _ApprovePageState createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  final List<String> _itemsNotApproved = [
    'Topic 1',
    'Topic 2',
    'Topic 3',
    'Topic 4',
    'Topic 5',
  ];

  final List<String> _itemsApproved = [
    'Topic 5',
    'Topic 6',
  ];
  String _lectureId = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Approve Page'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Not Approved'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: _itemsNotApproved.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_itemsNotApproved[index]),
                  trailing: ElevatedButton(
                    child: Text('Approve'),
                    onPressed: () {
                      _showModal(context, _itemsNotApproved[index]);
                    },
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: _itemsApproved.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_itemsApproved[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext context, String item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Approve $item'),
              onTap: () {
                setState(() {
                  _itemsNotApproved.remove(item);
                  _itemsApproved.add(item);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
