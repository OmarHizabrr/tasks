import 'package:get/get.dart';
import 'package:socialledger_new/database/DatabaseService.dart';
import 'package:socialledger_new/models/task.dart';

class CompletedTasksController extends GetxController {
  // خدمة قاعدة البيانات للتعامل مع عمليات البيانات
  final DatabaseService _databaseService = DatabaseService();
  
  // قائمة قابلة للملاحظة لتخزين المهام المكتملة
  final completedTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // بدء الاستماع للتغييرات في المهام المكتملة عند تهيئة المتحكم
    _listenToCompletedTasks();
  }

  // دالة للاستماع للتغييرات في المهام المكتملة من قاعدة البيانات
  void _listenToCompletedTasks() {
    _databaseService.getTasks().listen((allTasks) {
      // تصفية المهام لاستخراج المهام المكتملة فقط وتحديث القائمة المحلية
      completedTasks.assignAll(allTasks.where((task) => task.isCompleted.value));
    });
  }

  // دالة لحذف مهمة مكتملة
  Future<void> removeTask(Task task) async {
    // حذف المهمة من قاعدة البيانات
    await _databaseService.deleteTask(task.key!);
  }
}