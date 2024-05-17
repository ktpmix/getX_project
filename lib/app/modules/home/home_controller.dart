import 'package:flutter/foundation.dart';
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
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changeToDos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
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

  bool addToDo(String title) {
    var todo = {'title': title, 'done': false};
    var doneTodo = {'title': title, 'done': true};
    if (doingTodos.contains(todo) || doneTodos.contains(doneTodo)) {
      //is my logic right?
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateToDos() {
    var newToDOs = <Map<String, dynamic>>[];
    newToDOs.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    if (task.value != null) {
      var newTask = task.value!.copyWith(todos: newToDOs);
      int oldIndex = tasks.indexOf(task.value);
      tasks[oldIndex] = newTask;
      tasks.refresh();
    }
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);

    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();  
  }
}
