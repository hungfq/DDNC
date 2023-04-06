import 'package:ddnc_new/api/request/list_user_request.dart';
import 'package:ddnc_new/models/my_list_item.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';

class UserListView extends StatelessWidget {
  final service = ApiService.create();
  final List<MyListItem> items = [
    MyListItem(
      title: 'User 1',
      subtitle: 'Subtitle 1',
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/09/19/20/54/chains-947713_960_720.jpg',
    ),
    MyListItem(
      title: 'User 2',
      subtitle: 'Subtitle 2',
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/11/13/06/12/boy-529067_960_720.jpg',
    ),
    MyListItem(
      title: 'User 3',
      subtitle: 'Subtitle 3',
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/11/13/06/12/boy-529067_960_720.jpg',
    ),
  ];

  Future<dynamic> fetchUser() async {
    // var request = await ListUserRequest('10');
    // var data = await service.listUser(limit: 10, page: 1);
  }

  UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<dynamic>(
      future: fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot);
          return const Center(
            child: Text('An error occurred while fetching'),
          );
        } else if (snapshot.hasData) {
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(items[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            items[index].subtitle,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
