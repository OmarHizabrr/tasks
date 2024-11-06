import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialledger_new/controller/pending_tasks_controller.dart';

class PendingTasksView extends GetView<PendingTasksController> {
  const PendingTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المهام قيد الانتظار'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.pendingTasks.length,
        itemBuilder: (context, index) {
          final task = controller.pendingTasks[index];
          return ListTile(
            title: Text(task.title.value),
            subtitle: Text('${task.category.value} - ${DateFormat('yyyy-MM-dd HH:mm').format(task.date.value)}'),
            trailing: Checkbox(
              value: task.isCompleted.value,
              onChanged: (value) {
                task.isCompleted.value = value!;
                controller.updateTask(task);
              },
            ),
          );
        },
      )),
    );
  }
}