import 'package:ddnc_new/ui/admin_page/topic_section/topic_list.dart';
import 'package:ddnc_new/ui/admin_page/topic_section/topic_model.dart';
import 'package:ddnc_new/ui/pages/committee.dart';
import 'package:ddnc_new/ui/pages/schedule.dart';
import 'package:flutter/material.dart';
import 'admin_page/user_section/user_list.dart';
import 'package:ddnc_new/ui/admin_page/user_section/user_model.dart';

final List<User> users1 = [
  User(
      name: 'John Doe',
      email: 'johndoe@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Jane Doe',
      email: 'janedoe@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Bob Smith',
      email: 'bobsmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alice Smith',
      email: 'alicesmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alex Johnson',
      email: 'alexjohnson@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Olivia Williams',
      email: 'oliviawilliams@example.com',
      phone: '+1 (555) 555-5555'),
];

final List<User> users2 = [
  User(name: '123456', email: 'sdfsdf', phone: 'sdfsdf'),
  User(
      name: 'sdfsdf', email: 'janedoe@example.com', phone: '+1 (555) 555-5555'),
  User(
      name: 'Bob Smith33',
      email: 'bobsmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alice Smith444',
      email: 'alicesmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alex Johnso55n',
      email: 'alexjohnson@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Olivia 4444',
      email: 'oliviawilliams@example.com',
      phone: '+1 (555) 555-5555'),
];

final List<User> users3 = [
  User(name: '123456', email: 'sdfsdf', phone: 'sdfsdf'),
  User(
      name: 'sdfsssdf',
      email: 'janedoe@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Bob Smissth33',
      email: 'bobsmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alice Smith444',
      email: 'alicesmith@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Alex Johnssso55n',
      email: 'alexjohnson@example.com',
      phone: '+1 (555) 555-5555'),
  User(
      name: 'Olivia sss',
      email: 'oliviawilliams@example.com',
      phone: '+1 (555) 555-5555'),
];

final topics = [
  Topic(
    code: 'T001',
    title: 'Topic 1',
    description: 'This is the description of topic 1',
    limit: 3,
    lectureId: 1,
    criticalLecturerId: 2,
    students: ['John Doe', 'Jane Doe'],
    schedule: 'Monday - Friday',
    advisorLecturerGrade: 8,
    committeePresidentGrade: 9,
    committeeSecretaryLecturer: 7,
  ),
  Topic(
    code: 'T002',
    title: 'Topic 2',
    description: 'This is the description of topic 2',
    limit: 2,
    lectureId: 3,
    criticalLecturerId: 4,
    students: ['John Doe', 'Jane Doe', 'James Doe'],
    schedule: 'Monday - Wednesday',
    advisorLecturerGrade: 7,
    committeePresidentGrade: 8,
    committeeSecretaryLecturer: 6,
  ),
  Topic(
    code: 'T003',
    title: 'Topic 1',
    description: 'This is the description of topic 1',
    limit: 3,
    lectureId: 1,
    criticalLecturerId: 2,
    students: ['John Doe', 'Jane Doe'],
    schedule: 'Monday - Friday',
    advisorLecturerGrade: 8,
    committeePresidentGrade: 9,
    committeeSecretaryLecturer: 7,
  ),
  Topic(
    code: 'T004',
    title: 'Topic 1',
    description: 'This is the description of topic 1',
    limit: 3,
    lectureId: 1,
    criticalLecturerId: 2,
    students: ['John Doe', 'Jane Doe'],
    schedule: 'Monday - Friday',
    advisorLecturerGrade: 8,
    committeePresidentGrade: 9,
    committeeSecretaryLecturer: 7,
  ),
  Topic(
    code: 'T005',
    title: 'Topic 1',
    description: 'This is the description of topic 1',
    limit: 3,
    lectureId: 1,
    criticalLecturerId: 2,
    students: ['John Doe', 'Jane Doe'],
    schedule: 'Monday - Friday',
    advisorLecturerGrade: 8,
    committeePresidentGrade: 9,
    committeeSecretaryLecturer: 7,
  ),
  Topic(
    code: 'T006',
    title: 'Topic 1',
    description: 'This is the description of topic 1',
    limit: 3,
    lectureId: 1,
    criticalLecturerId: 2,
    students: ['John Doe', 'Jane Doe'],
    schedule: 'Monday - Friday',
    advisorLecturerGrade: 8,
    committeePresidentGrade: 9,
    committeeSecretaryLecturer: 7,
  ),
];

List<Schedule> schedules = [
  Schedule(
    id: '1',
    name: 'Schedule 1',
    code: 'SCH001',
    students: ['John Doe', 'Jane Doe'],
    description: 'This is the first schedule.',
    startProposalDate: DateTime(2023, 4, 1),
    endProposalDate: DateTime(2023, 4, 15),
    startApproveDate: DateTime(2023, 4, 16),
    endApproveDate: DateTime(2023, 4, 30),
    startRegisterDate: DateTime(2023, 5, 1),
    endRegisterDate: DateTime(2023, 5, 15),
    startDate: DateTime(2023, 6, 1, 9, 0),
    deadline: DateTime(2023, 6, 1, 17, 0),
  ),
  Schedule(
    id: '2',
    name: 'Schedule 2',
    code: 'SCH002',
    students: ['Alice Smith', 'Bob Smith'],
    description: 'This is the second schedule.',
    startProposalDate: DateTime(2023, 4, 1),
    endProposalDate: DateTime(2023, 4, 15),
    startApproveDate: DateTime(2023, 4, 16),
    endApproveDate: DateTime(2023, 4, 30),
    startRegisterDate: DateTime(2023, 5, 1),
    endRegisterDate: DateTime(2023, 5, 15),
    startDate: DateTime(2023, 6, 1, 9, 0),
    deadline: DateTime(2023, 6, 1, 17, 0),
  ),
];

// Assume you have retrieved data from a database or an API
List<Map<String, dynamic>> scheduleData = [
  {
    'id': '1',
    'name': 'Schedule 1',
    'code': 'SCH001',
    'students': ['John', 'Jane', 'Alice'],
    'description': 'Schedule 1 description',
    'startProposalDate': DateTime.now(),
    'endProposalDate': DateTime.now().add(Duration(days: 7)),
    'startApproveDate': DateTime.now().add(Duration(days: 8)),
    'endApproveDate': DateTime.now().add(Duration(days: 14)),
    'startRegisterDate': DateTime.now().add(Duration(days: 15)),
    'endRegisterDate': DateTime.now().add(Duration(days: 21)),
    'startDate': DateTime.now().add(Duration(days: 22)),
    'deadline': DateTime.now().add(Duration(days: 30)),
  },
  {
    'id': '2',
    'name': 'Schedule 2',
    'code': 'SCH002',
    'students': ['Bob', 'Mary', 'Tom'],
    'description': 'Schedule 2 description',
    'startProposalDate': DateTime.now(),
    'endProposalDate': DateTime.now().add(Duration(days: 7)),
    'startApproveDate': DateTime.now().add(Duration(days: 8)),
    'endApproveDate': DateTime.now().add(Duration(days: 14)),
    'startRegisterDate': DateTime.now().add(Duration(days: 15)),
    'endRegisterDate': DateTime.now().add(Duration(days: 21)),
    'startDate': DateTime.now().add(Duration(days: 22)),
    'deadline': DateTime.now().add(Duration(days: 30)),
  },
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    UserList(users: users1),
    UserList(users: users2),
    UserList(users: users3),
    TopicList(topics: topics),
    CommitteeListPage(),
    ScheduleListPage(schedules: schedules),
    UserList(users: users3),
    UserList(users: users3),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.account_circle), // or Person icon from another library
            label: 'Sinh viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school), // or School icon from another library
            label: 'Giảng Viên',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // or Settings icon from another library
            label: 'Quản trị',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.assignment), // or Assignment icon from another library
            label: 'Đề tài',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group), // or Group icon from another library
            label: 'Hội đồng',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.calendar_today), // or Calendar icon from another library
            label: 'Lịch đăng ký',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
