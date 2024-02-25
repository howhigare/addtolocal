import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:latihanaddtolocal/db/db_helper.dart';
import 'package:latihanaddtolocal/model/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteController extends GetxController {
 Database db = DbHelper.getDb();
  RxBool isLoading = false.obs;
  RxList<Movie> favorites = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  RxBool checkFavorite(int id) {
    return (favorites.any((item) => item.id == id)).obs;
  }

  void tapLike(Movie item) {
    if(checkFavorite(item.id).value){
      removeFavorite(item);
    } else {
      addFavorite(item);
    }
  }

  void addFavorite(Movie item) async {
    isLoading.value = true;
    var response = await get(Uri.parse(item.image));
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images";
    var filePathAndName = '${documentDirectory.path}/images/${item.id}.png';
    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    if (!await file.exists()) {
      file.writeAsBytesSync(response.bodyBytes);
      Movie movie = Movie(
        id: item.id,
        title: item.title,
        image: filePathAndName,
      );
      await db.insert("Movie", movie.toMap());
    }
    getFavorite();
  }

  void getFavorite() async {
    isLoading.value = true;
    List<Map<String, dynamic>> mapFavorites = await db.query("Movie");
    favorites.value = mapFavorites.map((e) => Movie.fromMap(map: e)).toList();
    isLoading.value = false;
  }

  void removeFavorite(Movie item) async {
    isLoading.value = true;
    await db.delete(
      "Movie",
      where: 'id = ?',
      whereArgs: [item.id],
    );
    var documentDirectory = await getApplicationDocumentsDirectory();
    var filePathAndName = '${documentDirectory.path}/images/${item.id}.png';
    File file = File(filePathAndName);

    if (await file.exists()) {
      await file.delete();
    }
    getFavorite();
  }

}
