import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:todo_getx/app/modules_home/controller/home_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
            ()=> HomeController()
    );
  }
}