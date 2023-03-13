import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/carte/create_cart.dart';
import 'package:freepayagency/pages/clients/show_client.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/ecommer/categorie/edit_category.dart';
import 'package:freepayagency/pages/ecommer/product/product_add.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/services/category_services.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class CategoryCard extends ConsumerWidget {
  final Categorys categorys;
  const CategoryCard({super.key, required this.categorys});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(CategoryProviders);
    return FadeInAnimation(
        child: Padding(
      padding: const EdgeInsets.only(left: 10.9, right: 10.9),
      child: Card(
        child: ListTile(
          onTap: () {
            Get.to(
                () => AddProduct(name: categorys.name, idcateg: categorys.id),
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
                  child: Image.network("${BaseImages}${categorys.img}"))),
          title: Text(
            categorys.name.toUpperCase(),
            style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 13),
            maxLines: 1,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  Get.showSnackbar(GetSnackBar(
                    message: "Voulez-vous supprimé?    Non",
                    title: "${appName}",
                    isDismissible: true,
                    onTap: (snack) {
                      Get.back();
                    },
                    mainButton: IconButton(
                        onPressed: () async {
                          await CategoryService().delateCategory(categorys.id);
                          controller.getCategorys();
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
                  Get.to(() => EditCategory(category: categorys),
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
