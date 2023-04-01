import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:ddnc_new/ui/side_bar.dart';
import 'package:ddnc_new/ui/content_section.dart';


class User {
  final String name;
  final String email;
  final String phone;

  User({required this.name, required this.email, required this.phone});
}

final List<User> users1 = [
  User(name: 'John Doe', email: 'johndoe@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Jane Doe', email: 'janedoe@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Bob Smith', email: 'bobsmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alice Smith', email: 'alicesmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alex Johnson', email: 'alexjohnson@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Olivia Williams', email: 'oliviawilliams@example.com', phone: '+1 (555) 555-5555'),
];

final List<User> users2 = [
  User(name: '123456', email: 'sdfsdf', phone: 'sdfsdf'),
  User(name: 'sdfsdf', email: 'janedoe@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Bob Smith33', email: 'bobsmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alice Smith444', email: 'alicesmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alex Johnso55n', email: 'alexjohnson@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Olivia 4444', email: 'oliviawilliams@example.com', phone: '+1 (555) 555-5555'),
];

final List<User> users3 = [
  User(name: '123456', email: 'sdfsdf', phone: 'sdfsdf'),
  User(name: 'sdfsssdf', email: 'janedoe@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Bob Smissth33', email: 'bobsmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alice Smith444', email: 'alicesmith@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Alex Johnssso55n', email: 'alexjohnson@example.com', phone: '+1 (555) 555-5555'),
  User(name: 'Olivia sss', email: 'oliviawilliams@example.com', phone: '+1 (555) 555-5555'),
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
    UserList(users: users3),
    UserList(users: users3),
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
            icon: Icon(Icons.account_circle), // or Person icon from another library
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
            icon: Icon(Icons.assignment), // or Assignment icon from another library
            label: 'Đề tài',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group), // or Group icon from another library
            label: 'Hội đồng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // or Calendar icon from another library
            label: 'Lịch đăng ký',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

    );
  }
}

class UserList extends StatefulWidget {
  final List<User> users;

  UserList({required this.users});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:         ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (BuildContext context, int index) {
          User user = widget.users[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserViewPage(user: user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed:  () async {
                      dynamic userUpdated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserEditPage(user: user),
                        ),
                      );
                      print(userUpdated);
                      setState(() {
                        widget.users[index] = User(name:userUpdated['name'], email: userUpdated['email'], phone: userUpdated['phone']);
                      });
                    },
                  ),
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
                                    widget.users.removeAt(index);
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
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserViewPage(user: user),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async  {
          User newUser =  await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserPage(),
            ),
          );
          setState(() {
            widget.users.add(newUser);
          });

        },
      ),
    );
  }
}



class UserViewPage extends StatelessWidget {
  final User user;

  UserViewPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: CircleAvatar(
                radius: 64.0,
                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/09/19/20/54/chains-947713_960_720.jpg'),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Name:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              user.email,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Phone:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              user.phone,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Address:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 8.0),
            // Text(
            //   user.address,
            //   style: TextStyle(
            //     fontSize: 16.0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class UserEditPage extends StatefulWidget {
  final User user;
  UserEditPage({required this.user});

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phone;
  // late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _email = widget.user.email;
    _phone = widget.user.phone;
    // _address = widget.user.address;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      String name = _name;
      // widget.user.name = _name;
      // widget.user.email = _email;
      // widget.user.phone = _phone;
      // widget.user.address = _address;
      Navigator.pop(context, {'name': _name, 'email': _email, 'phone': _phone});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _phone = value;
                },
              ),
              SizedBox(height: 16.0),
              // TextFormField(
              //   initialValue: _address,
              //   decoration: InputDecoration(
              //     labelText: 'Address',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter an address';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     _address = value;
              //   },
              // ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey != null &&  _formKey.currentState != null &&  _formKey.currentState!.validate()) {
                    final user = User(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                    );
                    Navigator.pop(context, user);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Topic {
  String code;
  String title;
  String description;
  int limit;
  int lectureId;
  int criticalLecturerId;
  List<String> students;
  String schedule;
  int advisorLecturerGrade;
  int committeePresidentGrade;
  int committeeSecretaryLecturer;

  Topic({
    required this.code,
    required this.title,
    required this.description,
    required this.limit,
    required this.lectureId,
    required this.criticalLecturerId,
    required this.students,
    required this.schedule,
    required this.advisorLecturerGrade,
    required this.committeePresidentGrade,
    required this.committeeSecretaryLecturer,
  });
}






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
                itemCount: topics.length,
                itemBuilder: (BuildContext context, int index) {
                  final topic = topics[index];
                  return Column(
                    children: [
                      Card(
                        child: InkWell(
                          onTap: () {
                            // Navigate to topic details
                          },
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
                      ),
                      Container(
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  // Remove the topic from the list
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Navigate to the topic editing screen
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  // Navigate to the topic detail screen
                                },
                              ),],
                          )
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      )
      ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}
