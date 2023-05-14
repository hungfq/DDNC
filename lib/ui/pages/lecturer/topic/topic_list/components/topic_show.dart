import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TopicShowPage extends StatelessWidget {
  final TopicInfo topic;

  TopicShowPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Topic'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.blue.shade400],
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
                      topic.title ?? "",
                      style: const TextStyle(
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Limit: ${topic.limit}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
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
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          maxLines: 3,
                          topic.description ?? "",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          topic.schedule?.name ?? "",
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 16.0),
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
                            for (var item in topic.studentCode ?? []) Text(item)
                          ],
                        ),
                        SizedBox(height: 16.0),
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
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    topic.advisorLecturerGrade.toString(),
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
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    topic.committeePresidentGrade.toString(),
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
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    topic.committeeSecretaryGrade.toString(),
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
