import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:latihanaddtolocal/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
 Database db = DbHelper.getDb();
  RxBool isMobileLayout = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    checkScreenWidth();
  }

  void checkScreenWidth() {
    double screenWidth = Get.width;
    isMobileLayout.value = screenWidth < 640;
  }

  @override
  void didChangeMetrics() {
    checkScreenWidth();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
