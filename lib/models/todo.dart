import 'dart:convert';

class Todo {
  final String title;
  final String desc;
  bool taskCompleted;
  Todo({
    required this.title,
    required this.desc,
    this.taskCompleted = false,
  });

  Todo copyWith({
    String? title,
    String? desc,
    bool? taskCompleted,
  }) {
    return Todo(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      taskCompleted: taskCompleted ?? this.taskCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'desc': desc,
      'taskCompleted': taskCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      desc: map['desc'] as String,
      taskCompleted: map['taskCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Todo(title: $title, desc: $desc, taskCompleted: $taskCompleted)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.desc == desc &&
        other.taskCompleted == taskCompleted;
  }

  @override
  int get hashCode => title.hashCode ^ desc.hashCode ^ taskCompleted.hashCode;
}
