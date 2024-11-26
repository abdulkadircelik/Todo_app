class TodoModel {
  final int id;
  final String title;
  final String? description;
  bool completed;

  TodoModel({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'description': description,
      };
}
