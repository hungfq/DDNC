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
