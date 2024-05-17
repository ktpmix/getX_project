import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/core/utils/extension.dart';
import 'package:getx_prac/app/core/values/colors.dart';
import 'package:getx_prac/app/data/models/task.dart';
import 'package:getx_prac/app/modules/home/home_controller.dart';
import 'package:getx_prac/app/modules/home/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              title: 'Task Type',
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homeCtrl.editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your title';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          runSpacing: 2.0.wp,
                          children: icons.map((e) {
                            final index = icons.indexOf(e);
                            return Obx(() {
                              return ChoiceChip(
                                selectedColor: Colors.grey[200],
                                pressElevation: 4,
                                backgroundColor: Colors.white,
                                label: e,
                                selected: homeCtrl.chipIndex.value == index,
                                onSelected: (selected) {
                                  if (selected) {
                                    homeCtrl.changeChipIndex(index);
                                  } else {
                                    homeCtrl.changeChipIndex(0);
                                  }
                                },
                              );
                            });
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (homeCtrl.formKey.currentState!.validate()) {
                            int icon =
                                icons[homeCtrl.chipIndex.value].icon!.codePoint;
                            String color =
                                icons[homeCtrl.chipIndex.value].color!.toHex();
                            var task = Task(
                                color: color,
                                icon: icon,
                                title: homeCtrl.editController.text);
                            Get.back();

                            homeCtrl.addTask(task)
                                ? EasyLoading.showSuccess(
                                    'Task added successfully')
                                : EasyLoading.showError('Task already exists');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              color: blue,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            minimumSize: const Size(150, 40)),
                        child: const Text('Confirm'),
                      ),
                    ],
                  )));
                  homeCtrl.editController.clear();
                  homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
              child: Icon(Icons.add, size: 10.0.wp, color: Colors.grey[400])),
        ),
      ),
    );
  }
}
