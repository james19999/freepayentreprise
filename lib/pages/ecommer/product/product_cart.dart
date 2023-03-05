import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/ecommer/product/product_detail.dart';
import 'package:freepayagency/pages/ecommer/product/product_edit.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(ProductProvider);
    return FadeInAnimation(
        child: Padding(
      padding: const EdgeInsets.only(left: 8.9, right: 8.9),
      child: Card(
        child: ListTile(
          onTap: () {
            Get.to(() => ProductDetail(product: product),
                transition: Transition.fade);
          },
          leading: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50)),
              height: 50,
              width: 50,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Image.network(
                    "${BaseImages}${product.img}",
                  ))),
          title: Text(
            product.name.toUpperCase(),
            style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 13),
            maxLines: 2,
          ),
          subtitle: Text(
            product.description.toUpperCase(),
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${product.price} XOF"),
              IconButton(
                onPressed: () async {
                  Get.showSnackbar(GetSnackBar(
                    message: "Voulez-vous supprimé ?    Non",
                    title: "${appName}",
                    isDismissible: true,
                    onTap: (snack) {
                      Get.back();
                    },
                    mainButton: IconButton(
                        onPressed: () async {
                          await controller.deleteProduct(product.id);
                          controller.getProducts();

                          Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        )),
                  ));
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: AppColors.mainColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(
                      () => EditProduct(
                            name: '',
                            idcateg: '',
                            product: product,
                          ),
                      transition: Transition.fade);
                },
                icon: Icon(
                  CupertinoIcons.pencil,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
