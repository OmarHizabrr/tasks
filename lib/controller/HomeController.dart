import 'package:get/get.dart';
import 'package:socialledger_new/database/DatabaseService.dart';
import 'package:socialledger_new/models/task.dart';

class HomeController extends GetxController {
  // خدمة قاعدة البيانات للتعامل مع عمليات البيانات
  final DatabaseService _databaseService = DatabaseService();
  
  // قائمة قابلة للملاحظة لتخزين المهام
  final tasks = <Task>[].obs;
  
  // تاريخ قابل للملاحظة لتخزين التاريخ المحدد حاليًا
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    // بدء الاستماع للتغييرات في المهام عند تهيئة المتحكم
    _listenToTasks();
  }

  // دالة للاستماع للتغييرات في المهام من قاعدة البيانات
  void _listenToTasks() {
    _databaseService.getTasks().listen((updatedTasks) {
      // تحديث قائمة المهام المحلية عند استلام تحديثات من قاعدة البيانات
      tasks.assignAll(updatedTasks);
    });
  }

  // دالة لإضافة مهمة جديدة
  Future<void> addTask(String title, String category) async {
    final task = Task(
      title: title,
      date: selectedDate.value,
      category: category,
    );
    // إضافة المهمة الجديدة إلى قاعدة البيانات
    await _databaseService.addTask(task);
  }

  // دالة لتحديث مهمة موجودة
  Future<void> updateTask(Task task) async {
    // تحديث المهمة في قاعدة البيانات
    await _databaseService.updateTask(task.key!, task);
  }

  // دالة لحذف مهمة
  Future<void> removeTask(Task task) async {
    // حذف المهمة من قاعدة البيانات
    await _databaseService.deleteTask(task.key!);
  }

  // دالة لتحديث التاريخ المحدد
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  // خاصية محسوبة للحصول على المهام للتاريخ المحدد
  List<Task> get tasksForSelectedDate {
    return tasks.where((task) => 
      // مقارنة السنة والشهر واليوم للمهمة مع التاريخ المحدد
      task.date.value.year == selectedDate.value.year &&
      task.date.value.month == selectedDate.value.month &&
      task.date.value.day == selectedDate.value.day
    ).toList();
  }
}