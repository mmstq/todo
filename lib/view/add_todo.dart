import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/custom_input_widgets.dart';
import 'package:todo/controller/todo_controller.dart';

class Add extends GetView<TodoController> {
   const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Add To Do',style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextInputField(
                controller: controller.titleController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                label: 'Title',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Enter todo title';
                  }
                  return null;
                },
              ),
              TextInputField(
                controller: controller.noteController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                label: 'Description',
                maxLines: 3,
              ),
              DatePicker(
                initialValue: DateFormat('dd MMM').format(controller.dueDate),
                label: 'Due Date',
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Select todo due date';
                  }
                  return null;
                },
                onChanged: (String? s)  {
                  controller.dueDate = DateTime.parse(s!);
                },

              ),
              const Spacer(),
              FilledButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  onPressed: () {
                    if(controller.formKey.currentState!.validate()){
                      controller.addData();
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(Icons.add_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
