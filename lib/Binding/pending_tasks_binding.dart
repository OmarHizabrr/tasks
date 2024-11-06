import 'package:get/get.dart';
import 'package:socialledger_new/controller/pending_tasks_controller.dart';


class PendingTasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingTasksController>(
      () => PendingTasksController(),
    );
  }
}