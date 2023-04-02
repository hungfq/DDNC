import 'package:ddnc_new/api/response/list_user_response.dart';
import 'package:flutter/material.dart';

class UserShowPage extends StatelessWidget {
  final UserInfo user;

  UserShowPage({required this.user});

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
                backgroundImage: NetworkImage(user.picture ?? 'https://cdn.pixabay.com/photo/2015/09/19/20/54/chains-947713_960_720.jpg'),
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
              user.name ?? "",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            const Text(
              'Email:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              user.email ?? "",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),
            const Text(
              'Code:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              user.code ?? "",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}




