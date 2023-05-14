import 'package:ddnc_new/api/response/list_topic_response.dart';
import 'package:flutter/material.dart';

class TopicSelectionMultiWithIdPage extends StatefulWidget {
  late List<int> selectedTopics;
  late List<TopicInfo> allTopics;
  late String pageTitle = "Topic";

  TopicSelectionMultiWithIdPage(
      {required this.selectedTopics,
      required this.allTopics,
      required this.pageTitle});

  @override
  _TopicSelectionMultiWithIdPageState createState() =>
      _TopicSelectionMultiWithIdPageState();
}

class _TopicSelectionMultiWithIdPageState extends State<TopicSelectionMultiWithIdPage> {
  late List<TopicInfo> _filteredTopic;
  late TextEditingController _searchController;

  @override
  void initState() {
    _filteredTopic = widget.allTopics;
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredTopic = widget.allTopics
          .where(
              (topic) => topic.id.toString().contains(query))
          .toList();
    });
  }

  void _onTopicSelected(int topicId) {
    setState(() {
      if (widget.selectedTopics.contains(topicId)) {
        widget.selectedTopics.remove(topicId);
      } else {
        widget.selectedTopics.add(topicId);
      }
    });
  }

  void _saveSelection() {
    Navigator.pop(context, widget.selectedTopics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.pageTitle}'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: _saveSelection,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ${widget.pageTitle}',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTopic.length,
              itemBuilder: (context, index) {
                final topic = _filteredTopic[index];
                final isSelected = widget.selectedTopics.contains(topic.id);
                return ListTile(
                  title: Text("${topic.code} - ${topic.title}"),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Colors.green : null,
                  ),
                  onTap: () => _onTopicSelected(topic.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
