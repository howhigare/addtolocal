import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihanaddtolocal/Api/movie_api.dart';
import 'package:latihanaddtolocal/db/db_helper.dart';
import 'package:latihanaddtolocal/pages/favorite/FavoriteBinding.dart';
import 'package:latihanaddtolocal/pages/favorite/FavoriteView.dart';
import 'package:latihanaddtolocal/pages/home/HomepageBinding.dart';
import 'package:latihanaddtolocal/pages/home/HomepageView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MovieApi());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/home",
      getPages: [
        GetPage(
            name: "/home",
            page: () => const HomeView(),
            binding: Homebinding()),
       GetPage(
            name: "/favorite",
            page: () => const Favorite(),
            binding: FavoriteBinding()),
      ],
    );
  }
}