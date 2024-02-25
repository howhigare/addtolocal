import 'package:get/get.dart';
import 'package:latihanaddtolocal/pages/home/HomepageController.dart';

class Homebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
