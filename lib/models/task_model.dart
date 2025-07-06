class TaskModel {
  String title;
  String date;
  String time;
  String status;

  TaskModel(
      {required this.title,
      required this.date,
      required this.time,
      required this.status});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"] ?? "",
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        status: json["status"] ?? 'new',
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "date": date,
        "time": time,
        "status": status,
      };
}
