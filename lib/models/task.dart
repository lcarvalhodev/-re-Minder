class Task {
  String title;
  String description;
  String? date;
  String? hour;
  String priority;
  String category;
  String? location;

  Task(
      {required this.title,
      required this.description,
      required this.priority,
      required this.category});
}
