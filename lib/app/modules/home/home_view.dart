import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/core/utils/extension.dart';
import 'package:getx_prac/app/modules/home/home_controller.dart';
import 'package:getx_prac/app/widgets/add_card.dart';
import 'package:getx_prac/app/widgets/task_card.dart';

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
                  ...controller.tasks
                      .map((task) => TaskCard(task: task))
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
