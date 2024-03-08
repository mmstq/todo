import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/frequent_widgets.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/view/add_todo.dart';

class See extends GetView<TodoController> {
  See({super.key});

  final List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() => controller.todos.isNotEmpty?ListView(
              children: controller.todos.map((element) {
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: Get.width*0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element.title,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(element.note,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.lightGreen),
                        child: Text(
                            '${element.dueDate.day} ${_months[element.dueDate.month]}',
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      hPad16,
                      InkWell(onTap: (){
                        controller.deleteTodo(element.id!);
                      }, child: const Icon(Icons.delete, color: Colors.redAccent,size: 20,)),
                    ],
                  ),
                );
              }).toList(),
            ): Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Todo', style: Get.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w800)),
                vPad16,
                const Text('Press + button to add.'),
              ],
            ),)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => Add()));
          // _controller.todos.refresh();
          // print('refresh');
        },
        tooltip: 'Add To Do',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
