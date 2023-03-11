import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/promotion_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/promotions/promotion_add.dart';
import 'package:freepayagency/pages/ecommer/promotions/promotion_card.dart';
import 'package:freepayagency/pages/ecommer/slider/add_slider.dart';
import 'package:get/get.dart';

class PromotionList extends ConsumerStatefulWidget {
  const PromotionList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromotionListState();
}

class _PromotionListState extends ConsumerState<PromotionList> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(PromotionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Promotions"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          Get.to(() => AddPromotion(), transition: Transition.fade);
        },
        child: const Icon(CupertinoIcons.add_circled),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            controller.promotions.isNotEmpty
                ? AnimationLimiter(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: controller.promotions.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: PromotionCard(
                                    promotion: controller.promotions[index],
                                  )),
                            );
                          }),
                    ),
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vous n'avez pas des produits en promotions."),
                    ],
                  ))
            // : Center(
            //     child: CircularProgressIndicator(
            //         color: AppColors.mainColor, strokeWidth: 1.5),
            //   )),
          ],
        ),
      )),
    );
  }
}
