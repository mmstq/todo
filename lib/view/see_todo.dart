import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/view/add_todo.dart';

class See extends StatefulWidget {
  const See({super.key});

  @override
  State<See> createState() => _SeeState();
}

class _SeeState extends State<See> {
  final TodoController _controller = Get.put(TodoController());
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
        backgroundColor: Colors.lightGreen,
        title: const Text('My Todo', style: TextStyle(fontWeight: FontWeight.w900),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() => ListView(
              children: _controller.todos.map((element) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              element.title,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
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
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(element.note,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    ],
                  ),
                );
              }).toList(),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Add()));
          // _controller.todos.refresh();
          // print('refresh');
        },
        tooltip: 'Add To Do',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
