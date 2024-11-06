
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialledger_new/controller/MyController.dart';

class MyScreen extends StatelessWidget {
  final MyController controller = Get.put(MyController());

   MyScreen({super.key});  // ربط الـ Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // عرض قائمة من العناصر باستخدام GetBuilder
          Expanded(
            child: GetBuilder<MyController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return GestureDetector(
                      onTap: () => controller.selectItem(item),
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // عرض العنصر المختار باستخدام GetBuilder
          GetBuilder<MyController>(
            builder: (controller) {
              return Text(
                'Selected Item: ${controller.selectedItem}',
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
