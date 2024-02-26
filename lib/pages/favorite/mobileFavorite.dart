import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihanaddtolocal/pages/favorite/FavoriteController.dart';

class MobileFavorite extends StatelessWidget {
  const MobileFavorite({Key? key, required this.favoriteController})
      : super(key: key);

  final FavoriteController favoriteController;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => favoriteController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : favoriteController.favorites.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Colors.amber,
                          size: 72,
                        ),
                        Text(
                          'No Favorite Item',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: favoriteController.favorites.length,
                      itemBuilder: (context, index) {
                        final data = favoriteController.favorites[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(data.image),
                                      width: widthScreen * 0.3,
                                      height: heightScreen * 0.14,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                AlertDialog alert = AlertDialog(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                  ),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.all(16.0),
                                                        child: Text(
                                                          "Are you sure to remove this product from your favorite list?",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              favoriteController.removeFavorite(data);
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "Remove",
                                                              style: TextStyle(
                                                                color: Colors.red,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );

                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.favorite_rounded,
                                                size: 20,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
