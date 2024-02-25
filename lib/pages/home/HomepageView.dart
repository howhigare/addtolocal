import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:latihanaddtolocal/pages/home/HomepageController.dart';
import 'package:latihanaddtolocal/pages/home/layout/mobilelayout.dart';
import 'package:latihanaddtolocal/pages/home/layout/tabletlayout.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/favorite");
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ],
      ),
      backgroundColor:Colors.white,
      body: Obx(
        () => controller.isMobileLayout.value
            ? const MobileLayout()
            : const TabletLayout(),
      ),
    );
  }
}
