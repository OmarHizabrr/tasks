import 'package:get/get.dart';

class MyController extends GetxController {
  List<String> items = [];  // قائمة من العناصر
  String selectedItem = '';

  @override
  void onInit() {
    super.onInit();
    // تحميل البيانات عند تهيئة الـ Controller
    loadItems();
  }

  void loadItems() {
    items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
    update();  // تحديث واجهة المستخدم
  }

  void selectItem(String item) {
    selectedItem = item;
    update();  // تحديث واجهة المستخدم بعد تغيير العنصر المختار
  }
}
