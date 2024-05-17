import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/data/models/task.dart';
import 'package:getx_prac/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rxn<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) {
      taskRepository.writeTasks(tasks);
    });
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? value) {
    task.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool updateTask(Task task, String textNewTask) {
    var todos = task.todos;

    if (containerToDo(todos, textNewTask)) {
      return false;
    }
    var todo = {'title': textNewTask, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containerToDo(List todos, String text) {
    return todos.any((element) => element['title'] == text);
  }
}
