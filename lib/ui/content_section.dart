import 'package:ddnc_new/ui/pages/committee.dart';
import 'package:flutter/material.dart';
import 'package:ddnc_new/ui/list_view_item.dart';

class ContentSection extends StatelessWidget {
  final PageController page;
  ContentSection({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: page,
        children: [
          Container(color: Colors.white, child: MyListView()),
          Container(
            color: Colors.white,
            child: CommitteeListPage(),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CommitteeListPage(),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Download',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Only Title',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Only Icon',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Hoi dong',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Lich dang ky',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Users',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Files',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Download',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Only Title',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Only Icon',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Hoi dong',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Lich dang ky',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
