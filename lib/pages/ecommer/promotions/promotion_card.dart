import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/controller/promotion_controller.dart';
import 'package:freepayagency/pages/controller/slider_controller.dart';
import 'package:freepayagency/pages/ecommer/product/product_detail.dart';
import 'package:freepayagency/pages/ecommer/product/product_edit.dart';
import 'package:freepayagency/pages/ecommer/promotions/promotion_edit.dart';
import 'package:freepayagency/pages/ecommer/slider/edit_slider.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/models/ecommer/promotion.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class PromotionCard extends ConsumerWidget {
  final Promotion promotion;
  const PromotionCard({super.key, required this.promotion});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(PromotionProvider);
    return FadeInAnimation(
        child: Padding(
            padding: const EdgeInsets.only(left: 8.9, right: 8.9, top: 8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => EditPromot(
                      promotion: promotion,
                    ));
              },
              child: Container(
                height: Get.height * 0.2,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5, color: AppColors.mainColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: Get.height * 0.15,
                        width: Get.width * 0.34,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Image.network(
                              "${BaseImagepromot}${promotion.img}",
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Container(
                      decoration: BoxDecoration(),
                      height: Get.height * 0.2,
                      width: Get.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  promotion.title,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
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
                                              await controller.delatepromotion(
                                                  promotion.id);
                                              controller.getPromotion();
                                              Get.back();
                                            },
                                            icon: Icon(
                                              CupertinoIcons.delete,
                                              color: Colors.red,
                                            )),
                                      ));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${promotion.normal_price} XOF",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      decoration: TextDecoration.lineThrough),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${promotion.promot_price} XOF",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "début: ${promotion.start_date} ",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "fin: ${promotion.end_date} ",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ]),
              ),
            )));
  }
}
