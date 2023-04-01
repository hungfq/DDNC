import 'package:ddnc_new/ui/admin_page/user_section/user_add.dart';
import 'package:ddnc_new/ui/admin_page/user_section/user_edit.dart';
import 'package:ddnc_new/ui/admin_page/user_section/user_model.dart';
import 'package:ddnc_new/ui/admin_page/user_section/user_view.dart';
import 'package:flutter/material.dart';

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
                      if( userUpdated !=null) {
                        setState(() {
                          widget.users[index] = User(name:userUpdated['name'], email: userUpdated['email'], phone: userUpdated['phone']);
                        });
                      }
                      print(userUpdated);

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

