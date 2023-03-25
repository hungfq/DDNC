import 'package:ddnc_new/models/my_list_item.dart';
import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  final List<MyListItem> items = [
    MyListItem(
      title: 'Item 1',
      subtitle: 'Subtitle 1',
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/09/19/20/54/chains-947713_960_720.jpg',
    ),
    MyListItem(
      title: 'Item 2',
      subtitle: 'Subtitle 2',
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/11/13/06/12/boy-529067_960_720.jpg',
    ),
    MyListItem(
      title: 'Item 3',
      subtitle: 'Subtitle 3',
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/11/13/06/12/boy-529067_960_720.jpg  ',
    ),
  ];

  MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: ListView.separated(
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
                        style: TextStyle(
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
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          );
        },
      ),
    );
  }
}
