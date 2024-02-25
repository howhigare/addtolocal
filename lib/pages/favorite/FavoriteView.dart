import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:latihanaddtolocal/pages/favorite/FavoriteController.dart';
import 'package:latihanaddtolocal/pages/favorite/mobileFavorite.dart';
import 'package:latihanaddtolocal/pages/home/HomepageController.dart';

class Favorite extends GetView<FavoriteController> {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController layoutController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.red,
        backgroundColor: Colors.white30,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() => layoutController.isMobileLayout.value
          ? MobileFavorite(favoriteController: controller)
          : MobileFavorite(favoriteController: controller)),
    );
  }
}
