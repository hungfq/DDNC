import 'package:ddnc_new/ui/admin_page/topic_section/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TopicViewPage extends StatelessWidget {
  final Topic topic;

  TopicViewPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple.shade400, Colors.blue.shade400],
            ),
          ),
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Topic Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  topic.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Code: ${topic.code}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'Limit: ${topic.limit}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
          child: Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Description',
    style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 8.0),
    Text(
    topic.description,
    style: TextStyle(
    fontSize: 16.0,
    ),
    ),
    SizedBox(height: 16.0),
    Text(
    'Schedule',
    style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 8.0),
    Text(
    topic.schedule,
    style: TextStyle(
    fontSize: 16.0,
    ),
    ),
    SizedBox(height: 16.0),
    Text(
    'Students',
    style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 8.0),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: topic.students.map(
    (student) => Text(
    '- $student',
    style: TextStyle(
    fontSize: 16.0,
    ),
    ),
    ).toList(),
    ),
    SizedBox(height: 16.0),
    Text(
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
    Text(
    'Advisor Lecturer',
    style: TextStyle(
    fontSize: 16.0,
    ),
    ),
    SizedBox(height: 8.0),
      Text(
        topic.advisorLecturerGrade.toString(),
        style: TextStyle(
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
            Text(
              'Committee President',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              topic.committeePresidentGrade.toString(),
              style: TextStyle(
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
            Text(
              'Committee Secretary',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              topic.committeeSecretaryLecturer.toString(),
              style: TextStyle(
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
      ElevatedButton(
        onPressed: () {},
        child: Text('Apply'),
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    ],
    ),
        ),
          ),
          ),
                ],
            ),
          ),
        ),
    );
  }
}

