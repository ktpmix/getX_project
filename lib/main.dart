import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_prac/app/data/services/storage/services.dart';
import 'package:getx_prac/app/modules/home/home_binding.dart';
import 'package:getx_prac/app/modules/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure flutter binding is initialized
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Todo List using GetX',
      home: const  HomePage(),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder:EasyLoading.init() ,
    );
  }
}