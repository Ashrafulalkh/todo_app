class TaskModel {
  final int id;
  final DateTime? createdAt;
  final String title;
  final String description;
  final bool isCompleted;
  final String userId;

  TaskModel({
    required this.id,
    this.createdAt,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.userId,
  });

  // Factory constructor to create a Task object from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['is_completed'] as bool,
      userId: json['user_id'] as String,
    );
  }

  // Method to convert a Task object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'user_id': userId,
    };
  }

  // // Static method to parse a list of Task objects from JSON
  // static List<Task> fromJsonList(List<dynamic> jsonList) {
  //   return jsonList.map((json) => Task.fromJson(json)).toList();
  // }
  //
  // // Static method to convert a list of Task objects into JSON
  // static List<Map<String, dynamic>> toJsonList(List<Task> taskList) {
  //   return taskList.map((task) => task.toJson()).toList();
  // }

  // Optional toString override for better debugging
  // @override
  // String toString() {
  //   return 'Task{id: $id, createdAt: $createdAt, title: $title, description: $description, isCompleted: $isCompleted, userId: $userId}';
  // }
}