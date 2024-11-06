// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socialledger_new/controller/HomeController.dart';
import 'package:socialledger_new/models/task.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدير المهام'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTaskDialog(context),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'completed') {
                Get.toNamed('/completed-tasks');
              } else if (value == 'pending') {
                Get.toNamed('/pending-tasks');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'completed',
                child: Text('المهام المنفذة'),
              ),
              const PopupMenuItem<String>(
                value: 'pending',
                child: Text('المهام قيد الانتظار'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCurrentDateTime(),
          _buildCalendar(),
          _buildTaskList(),
        ],
      ),
    );
  }

  // بناء وعرض التاريخ والوقت الحالي
  Widget _buildCurrentDateTime() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(controller.selectedDate.value),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
  }

  // بناء وعرض التقويم
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: controller.selectedDate.value,
      selectedDayPredicate: (day) =>
          isSameDay(controller.selectedDate.value, day),
      onDaySelected: (selectedDay, focusedDay)  {
        controller.updateSelectedDate(selectedDay);
      },
      calendarFormat: CalendarFormat.month,
      // إزالة الخصائص غير الضرورية
    );
  }

  // بناء وعرض قائمة المهام
  Widget _buildTaskList() {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: controller.tasksForSelectedDate.length,
            itemBuilder: (context, index) {
              final task = controller.tasksForSelectedDate[index];
              return Obx(() => ListTile(
                    title: Text(task.title.value),
                    subtitle: Text(
                        '${task.category.value} - ${DateFormat('HH:mm').format(task.date.value)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isCompleted.value,
                          onChanged: (value) {
                            task.isCompleted.value = value!;
                            controller.updateTask(task);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditTaskDialog(context, task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.removeTask(task),
                        ),
                      ],
                    ),
                  ));
            },
          )),
    );
  }

  // عرض نافذة إضافة مهمة جديدة
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final categoryController = TextEditingController();
    final timeController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('إضافة مهمة جديدة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'عنوان المهمة'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(hintText: 'الفئة'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(hintText: 'الوقت (HH:mm)'),
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    timeController.text =
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('إضافة'),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  timeController.text.isNotEmpty) {
                timeController.text.split(':');
                controller.addTask(
                  titleController.text,
                  categoryController.text,

                
                );
                Get.back();
              }
            },
          ),
        ],
      ),
    );
  }

  // عرض نافذة تعديل المهمة
  void _showEditTaskDialog(BuildContext context, Task task) {
    final titleController = TextEditingController(text: task.title.value);
    final categoryController = TextEditingController(text: task.category.value);
    final timeController = TextEditingController(
        text: DateFormat('HH:mm').format(task.date.value));

    Get.dialog(
      AlertDialog(
        title: const Text('تعديل المهمة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'عنوان المهمة'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(hintText: 'الفئة'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(hintText: 'الوقت (HH:mm)'),
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(task.date.value),
                  );
                  if (time != null) {
                    timeController.text =
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('حفظ'),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  timeController.text.isNotEmpty) {
                final time = timeController.text.split(':');
                task.title.value = titleController.text;
                task.category.value = categoryController.text;
                task.date.value = DateTime(
                  task.date.value.year,
                  task.date.value.month,
                  task.date.value.day,
                  int.parse(time[0]),
                  int.parse(time[1]),
                );
                controller.updateTask(task);
                Get.back();
                // controller.();
              }
            },
          ),
        ],
      ),
    );
  }
}