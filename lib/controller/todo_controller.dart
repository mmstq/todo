import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var dueDate = DateTime.now();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void onInit() {
    _getData();
    dateController.text = formatDate(dueDate);
    super.onInit();
  }

  String formatDate(DateTime time) {
    return "${time.day.toString().padLeft(2, '0')}/"
        "${time.month.toString().padLeft(2, '0')}/"
        "${time.year.toString()}";
  }

  void _getData() {
    DatabaseHelper.instance.queryAllRows().then((value) {
      for (var element in value) {
        todos.add(Todo(
            id: element['id'],
            title: element['title'],
            note: element['note'],
            dueDate: DateTime.parse(element['dueDate'])));
      }
    });
  }

  void addData() async {

    await DatabaseHelper.instance.insert(Todo(
        title: titleController.text, note: noteController.text, dueDate: dueDate));
    todos.insert(
        0,
        Todo(
            title: titleController.text,
            note: noteController.text,
            dueDate: dueDate));
    titleController.clear();
    noteController.clear();
  }
}
