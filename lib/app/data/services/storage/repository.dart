import 'package:getx_prac/app/data/models/task.dart';
import 'package:getx_prac/app/data/providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() {
    return taskProvider.readTasks();
  }

  void writeTasks(List<Task> tasks) {
    return taskProvider.writeTasks(tasks);
  }
}