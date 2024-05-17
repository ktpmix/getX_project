import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/core/utils/extension.dart';
import 'package:getx_prac/app/modules/home/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 65.0.wp,
                fit: BoxFit.cover,
              ),
              Text(
                'Add Task',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos.map((element) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp, horizontal: 9.0.wp),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            fillColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.grey),
                            value: element['done'],
                            onChanged: (value) {
                              homeCtrl.doneTodo(element['title']);
                            },
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.0.wp),
                          child: Text(
                            element['title'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
                  if(homeCtrl.doneTodos.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
            ],
          ));
  }
}
