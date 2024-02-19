import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihanaddtolocal/controller/ControllerListProduct.dart';

class ProductListPage extends StatelessWidget {
  final productController = Get.put(ControllerListProduct());
  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data API"),
      ),
      body: Center(
        child: Obx(() => productController.isLoading.value
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Text("Welcome " +
                      productController.sessionUsername.value.toString()),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productController.productResponModelCtr.length,
                        itemBuilder: (BuildContext ctx, int idx) {
                          // mengambil object per index nya dibuat var product
                          final product =
                              productController.productResponModelCtr[idx];
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.name),
                                  ),
                                  Container(
                                    height: 200,
                                    width: 200,
                                    child: Image(image: NetworkImage(product.imageLink))                                 )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )),
      ),
    );
  }
}