import 'package:get/get.dart';

import '../controller/home_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}