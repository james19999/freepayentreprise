import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/add_category.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_card.dart';
import 'package:freepayagency/pages/ecommer/product/product_cart.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Détails produit"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ZoomTapAnimation(
              child: Container(
                height: Get.height * 0.6,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "${BaseImages}${widget.product.img}",
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: StyleText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "${widget.product.price.toString()} XOF",
                        style: StyleText.copyWith(fontSize: fontsizes),
                      )),
                    ],
                  ),
                  Divider(
                    height: Get.height * 0.02,
                    color: AppColors.mainColor,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.description,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
