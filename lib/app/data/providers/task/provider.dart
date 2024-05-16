import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_prac/app/core/utils/key.dart';
import 'package:getx_prac/app/data/models/task.dart';
import 'package:getx_prac/app/data/services/storage/services.dart';

class TaskProvider{
  final StorageService _storage =Get.find<StorageService>();
  
  List<Task> readTasks(){
    var tasks =<Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach((task){
      tasks.add(Task.fromJson(task));
    });
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    List<Map<String, dynamic>> taskList =[];
    tasks.forEach((task){
      taskList.add(task.toJson());
    });
    _storage.write(taskKey, jsonEncode(taskList));
  }
}