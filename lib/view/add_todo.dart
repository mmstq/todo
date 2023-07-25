import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/todo_controller.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TodoController _controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Add To Do',style: TextStyle(fontWeight: FontWeight.w900),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: _controller.titleController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (value) {
                return null;
              },
              decoration: getDecoration(labelText: 'Title'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _controller.noteController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              maxLines: 3,
              validator: (value) {
                return null;
              },
              decoration: getDecoration(
                labelText: 'Note',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _controller.dateController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.none,
              showCursor: false,
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.characters,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024));
                if (picked != null) {
                  _controller.dueDate = picked;
                  _controller.dateController.text =
                      _controller.formatDate(picked);
                }
                FocusNode().unfocus();
              },
              decoration: getDecoration(labelText: 'Due Date').copyWith(
                prefixIcon: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.lightGreen,
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                onPressed: () {
                  _controller.addData();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.add_rounded))
          ],
        ),
      ),
    );
  }

  InputDecoration getDecoration({required String labelText}) {
    final decoration = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12, width: 1.5));
    return InputDecoration(
      filled: true,
      labelText: labelText,
      contentPadding: const EdgeInsets.all(22),
      errorBorder: decoration.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 1.5)),
      enabledBorder: decoration,
      disabledBorder: decoration,
      focusedBorder: decoration.copyWith(
          borderSide: const BorderSide(color: Colors.lightGreen, width: 1.5)),
      fillColor: Colors.white,
    );
  }
}
