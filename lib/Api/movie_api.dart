import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latihanaddtolocal/model/ProductResponseModel.dart';

class MovieApi extends GetxController {
  RxList<MovieModel> resultctr = <MovieModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isOffline = false.obs;

  StreamSubscription? connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    loadData();
    startMonitoringConnectivity();
  }

  @override
  void onClose() {
    connectivitySubscription?.cancel();
    super.onClose();
  }

  loadData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=c5a08a2d246ab58398fc520d9b8ef159"));

      if (response.statusCode == 200) {
        // Mengisi data dengan hasil json dari model
        resultctr.value = movieResponseModelFromJson(response.body).results;
      } else {
        print("Status Code : ${response.statusCode}");
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false; // Mengubah isLoading menjadi false jika terjadi error
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void startMonitoringConnectivity() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        isOffline.value = true;
        resultctr.clear();
      } else {
        isOffline.value = false;
        loadData();
      }
    });
  }
}
