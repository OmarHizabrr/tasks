import 'package:get/get.dart';

class Task {
  String? key;
  RxString title;
  Rx<DateTime> date;
  RxBool isCompleted;
  RxString category;

  Task({
    this.key,
    required String title,
    required DateTime date,
    bool isCompleted = false,
    String category = 'personal',
  })  : title = title.obs,
        date = date.obs,
        isCompleted = isCompleted.obs,
        category = category.obs;

  // Преобразование в JSON для сохранения в базе данных
  Map<String, dynamic> toJson() {
    return {
      'title': title.value,
      'date': date.value.toIso8601String(),
      'isCompleted': isCompleted.value,
      'category': category.value,
    };
  }

  // Создание объекта Task из JSON
  factory Task.fromJson(Map<String, dynamic> json, {String? key}) {
    return Task(
      key: key,
      title: json['title'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
      category: json['category'],
    );
  }
}