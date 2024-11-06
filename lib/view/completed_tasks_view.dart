import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialledger_new/controller/completed_tasks_controller.dart';

class CompletedTasksView extends GetView<CompletedTasksController> {
  const CompletedTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المهام المنفذة'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.completedTasks.length,
        itemBuilder: (context, index) {
          final task = controller.completedTasks[index];
          return ListTile(
            title: Text(task.title.value),
            subtitle: Text('${task.category.value} - ${DateFormat('yyyy-MM-dd HH:mm').format(task.date.value)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => controller.removeTask(task),
            ),
          );
        },
      )),
    );
  }
}