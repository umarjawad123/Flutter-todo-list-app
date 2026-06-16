class TaskModel {
  String task;
  bool isDone;

  TaskModel({required this.task, this.isDone = false});

  Map<String, dynamic> toJson() {
    return {'task': task, 'isDone': isDone};
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(task: json["task"], isDone: json["isDone"]);
  }
}
