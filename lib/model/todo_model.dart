class Todo {
  int? id;
  String title;
  String note;
  DateTime dueDate;

  Todo(
      {this.id,
      required this.title,
      required this.note,
      required this.dueDate});

  Map<String, dynamic> toMap() =>
      {'id': id, 'title': title, 'note': note, 'dueDate': dueDate.toString()};

  Todo fromMap(Map<String, dynamic> map) => Todo(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      dueDate: map['dueDate']);
}
