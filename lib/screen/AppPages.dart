



import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:socialledger_new/Binding/Binding.dart';
import 'package:socialledger_new/Binding/completed_tasks_binding.dart';
import 'package:socialledger_new/Binding/pending_tasks_binding.dart';
import 'package:socialledger_new/view/HomeView.dart';
import 'package:socialledger_new/view/completed_tasks_view.dart';
import 'package:socialledger_new/view/pending_tasks_view.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_TASKS,
      page: () => CompletedTasksView(),
      binding: CompletedTasksBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_TASKS,
      page: () => PendingTasksView(),
      binding: PendingTasksBinding(),
    ),
  ];
}

abstract class Routes {
  Routes._();
  // ignore: constant_identifier_names
  static const HOME = _Paths.HOME;
  static const COMPLETED_TASKS = _Paths.COMPLETED_TASKS;
  static const PENDING_TASKS = _Paths.PENDING_TASKS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const COMPLETED_TASKS = '/completed-tasks';
  static const PENDING_TASKS = '/pending-tasks';
}