import 'package:flutter/material.dart';

class MarkPage extends StatefulWidget {
  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View Example'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]),
            onTap: () {
              _showModal(context, _items[index]);
            },
          );
        },
      ),
    );
  }

  void _showModal(BuildContext context, String item) {
    String _field1Value = '';
    String _field2Value = '';
    String _field3Value = '';

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Field 1'),
                      onChanged: (value) {
                        setState(() {
                          _field1Value = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Field 2'),
                      onChanged: (value) {
                        setState(() {
                          _field2Value = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Field 3'),
                      onChanged: (value) {
                        setState(() {
                          _field3Value = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: Text('Save'),
                          onPressed: () {
                            // Do something with the field values here
                            print('Field 1: $_field1Value');
                            print('Field 2: $_field2Value');
                            print('Field 3: $_field3Value');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
