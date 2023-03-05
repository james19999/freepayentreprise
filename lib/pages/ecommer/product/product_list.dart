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
import 'package:freepayagency/pages/ecommer/product/product_add.dart';
import 'package:freepayagency/pages/ecommer/product/product_cart.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ProductProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Produits"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          Get.to(() => AddProduct(name: '', idcateg: ''),
              transition: Transition.fade);
        },
        child: const Icon(CupertinoIcons.add_circled),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 10),
            child: TextFormField(
              controller: _textEditingController,
              onChanged: (value) {
                controller.filterCrop(value);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsetsGeometry.lerp(
                      EdgeInsets.all(5.0), EdgeInsets.all(8.0), 1),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: AppColors.mainColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: AppColors.mainColor,
                    ),
                  ),
                  hintText: "Rechercher un produit",
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: iconsizes,
                  ),
                  // suffixIcon: _textEditingController.text.length > 0
                  //     ? IconButton(
                  //         onPressed: () {
                  //           _textEditingController.clear();
                  //         },
                  //         icon: Icon(Icons.clear))
                  //     : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Expanded(
              child: _textEditingController.text.isNotEmpty &&
                      controller.filteredTempCropList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search_off,
                                size: 80,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Aucune résultat pour votre recherche',
                                  style: TextStyle(
                                      fontSize: fontsizes,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : controller.filteredTempCropList.isNotEmpty
                      ? AnimationLimiter(
                          child: ListView.builder(
                              itemCount: controller.product.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: ProductCard(
                                        product: controller.product[index],
                                      )),
                                );
                              }),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor, strokeWidth: 1.5),
                        )),
        ],
      )),
    );
  }
}
