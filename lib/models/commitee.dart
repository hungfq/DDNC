// committee.dart

import '../ui/admin_page/user_section/user_model.dart';

class Committee {
  final int? id;
  final String code;
  final String name;
  final User president;
  final User secretary;
  final User criticalMember;

  Committee({
    required this.id,
    required this.code,
    required this.name,
    required this.president,
    required this.secretary,
    required this.criticalMember,
  });
}
