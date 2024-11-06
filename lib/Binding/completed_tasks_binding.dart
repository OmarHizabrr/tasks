import 'package:get/get.dart';
import 'package:socialledger_new/controller/completed_tasks_controller.dart';


class CompletedTasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedTasksController>(
      () => CompletedTasksController(),
    );
  }
}