import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _itemsNotApproved = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<String> _itemsApproved = [];
  String _lectureId = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List View Example'),
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
            DropdownButtonFormField<String>(
              value: _lectureId,
              decoration: InputDecoration(
                labelText: 'Lecture',
                border: OutlineInputBorder(),
              ),
              items: ['1', '2', '3', '4', '5']
                  .map((value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text('Lecture $value'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _lectureId = value!;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a lecture';
                }
                return null;
              },
            ),
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
