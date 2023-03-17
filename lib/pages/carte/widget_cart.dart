import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/carte/cart_transaction_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/models/cart_client.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CartCard extends ConsumerWidget {
  final Cart cart;
  const CartCard({super.key, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ZoomTapAnimation(
      child: InkWell(
        onTap: () {
          Get.to(() => Transactionlist(cart: cart),
              transition: Transition.fade);
        },
        child: Container(
          child: Center(
              child: Card(
            color: Colors.white,
            elevation: 3,
            child: Container(
              height: Get.height * 0.23,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Free Pay Carte",
                          style: StyleText.copyWith(
                              color: AppColors.mainColor, fontSize: fontsizes),
                        ),
                        Text(
                          cart.status == 1 ? "Activée".tr : "Désactivée".tr,
                          style: StyleText.copyWith(
                              color:
                                  cart.status == 1 ? Colors.green : Colors.red,
                              fontSize: fontsizes),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cart.code,
                          style: StyleText.copyWith(
                            color: AppColors.mainColor,
                            letterSpacing: 3.0,
                            fontSize: fontsizes,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          "${cart.amount} XOF",
                          style: StyleText.copyWith(
                            color: AppColors.mainColor,
                            letterSpacing: 3.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.022,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cart.client!.name,
                            style: StyleText.copyWith(
                              color: AppColors.mainColor,
                              fontSize: fontsizes,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          cart.created,
                          style: StyleText.copyWith(
                            color: AppColors.mainColor,
                            fontSize: fontsizes,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
