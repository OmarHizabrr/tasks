
import 'package:get/get.dart';
import 'package:socialledger_new/controller/HomeController.dart';
import 'package:socialledger_new/models/task.dart';


class TasksController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  List<Task> get tasks => homeController.tasks;
}