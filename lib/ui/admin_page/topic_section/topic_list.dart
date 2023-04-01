import 'package:ddnc_new/ui/admin_page/topic_section/topic_edit.dart';
import 'package:ddnc_new/ui/admin_page/topic_section/topic_model.dart';
import 'package:ddnc_new/ui/admin_page/topic_section/topic_view.dart';
import 'package:flutter/material.dart';
class TopicList extends StatefulWidget {
  final List<Topic> topics;

  TopicList({required this.topics});

  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {


  void _addTopic(t) {
    // setState(() {
    //   _topics.add(Topic());
    // });
  }

  void _editTopic(int index) {
    // TODO: implement topic editing
  }

  void _removeTopic(int index) {
    setState(() {
      widget.topics.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.topics.length,
                itemBuilder: (BuildContext context, int index) {
                  final topic = widget.topics[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicViewPage(topic: topic),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          topic.title,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        topic.code,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    topic.description,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 16.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        '${topic.lectureId} (Lecturer)',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: Colors.grey,
                                        size: 16.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        '${topic.criticalLecturerId} (Critical Lecturer)',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text("Are you sure you want to delete this user?"),
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
                                              setState(() {
                                                widget.topics.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async  {
                                  Topic? updatedTopic = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopicEditPage(topic: topic),
                                    ),
                                  );
                                  if (updatedTopic != null) {
                                    setState(() {
                                      widget.topics[index] = updatedTopic;
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TopicViewPage(topic: topic),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );

  }
}
