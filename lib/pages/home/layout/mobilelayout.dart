  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
  import 'package:get/get.dart';
  import 'package:latihanaddtolocal/Api/movie_api.dart';
  import 'package:latihanaddtolocal/model/AppConstant.dart';
  import 'package:latihanaddtolocal/model/product_model.dart';
  import 'package:latihanaddtolocal/pages/favorite/FavoriteController.dart';


 class MobileLayout extends StatelessWidget {
  const MobileLayout({Key? key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final FavoriteController movieController = Get.put(FavoriteController());
    final MovieApi apiController = Get.put(MovieApi());
    return Obx(() {
      if (apiController.isOffline.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_statusbar_connected_no_internet_4,
                size: 72,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'No Internet Connection , Please Connect to Internet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      }
      return apiController.resultctr.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 5.5,
                        children: [],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.70,
                      ),
                      padding: const EdgeInsets.only(top: 45, bottom: 110),
                      itemCount: apiController.resultctr.length,
                      itemBuilder: (context, index) {
                        final data = apiController.resultctr[index];
                        final image =
                            "${AppConstant.imageurl}${data.posterPath}";
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.1), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: widthScreen * 0.3,
                                    height: heightScreen * 0.14,
                                    foregroundDecoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            data.title,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Obx(
                                              () => IconButton(
                                                onPressed: () {
                                                  movieController.tapLike(
                                                    Movie(
                                                        id: data.id,
                                                        title: data.title,
                                                        image: image),
                                                  );
                                                },
                                                icon: Icon(
                                                  movieController
                                                          .checkFavorite(
                                                              data.id)
                                                          .value
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_outline_rounded,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
    });
  }
}