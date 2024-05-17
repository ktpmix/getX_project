import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/core/utils/extension.dart';
import 'package:getx_prac/app/data/models/task.dart';
import 'package:getx_prac/app/modules/home/home_controller.dart';
import 'package:getx_prac/app/modules/home/widgets/add_card.dart';
import 'package:getx_prac/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_prac/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks.map((task) => LongPressDraggable(
                      data: task,
                      onDragStarted: () {
                        controller.changeDeleting(true);
                      },
                      onDraggableCanceled: (_, __) {
                        //
                        controller.changeDeleting(false);
                      },
                      onDragEnd: (_) {
                        controller.changeDeleting(false);
                      },
                      feedback: Opacity(
                        opacity: 0.8,
                        child: TaskCard(task: task),
                      ),
                      child: TaskCard(task: task))),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
               if(controller.tasks.isNotEmpty){
                 Get.to(()=> AddDialog(),transition: Transition.downToUp);
               }
               else{
                EasyLoading.showInfo('Add Task First');
               }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAcceptWithDetails: (DragTargetDetails<Task> details) {
          controller.deleteTask(details.data);
          EasyLoading.showSuccess('Task Deleted');
        },
      ),
    );
  }
}
