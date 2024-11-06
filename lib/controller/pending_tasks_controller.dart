import 'package:get/get.dart';
import 'package:socialledger_new/database/DatabaseService.dart';
import 'package:socialledger_new/models/task.dart';


class PendingTasksController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();
  final pendingTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _listenToPendingTasks();
  }

  void _listenToPendingTasks() {
    _databaseService.getTasks().listen((allTasks) {
      pendingTasks.assignAll(allTasks.where((task) => !task.isCompleted.value));
    });
  }

  Future<void> updateTask(Task task) async {
    await _databaseService.updateTask(task.key!, task);
  }
}