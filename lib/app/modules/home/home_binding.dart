import 'package:get/get.dart';
import 'package:getx_prac/app/data/providers/task/provider.dart';
import 'package:getx_prac/app/data/services/storage/repository.dart';
import 'package:getx_prac/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
      taskRepository: TaskRepository(taskProvider: TaskProvider())
    ));
  }
}