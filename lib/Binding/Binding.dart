
import 'package:get/get.dart';
import 'package:socialledger_new/controller/HomeController.dart';
import 'package:socialledger_new/controller/TasksController.dart';


class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(() => TasksController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
