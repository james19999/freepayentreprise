import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/controller/slider_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/product/product_add.dart';
import 'package:freepayagency/pages/ecommer/product/product_cart.dart';
import 'package:freepayagency/pages/ecommer/slider/add_slider.dart';
import 'package:freepayagency/pages/ecommer/slider/slider_card.dart';
import 'package:get/get.dart';

class SlideList extends ConsumerStatefulWidget {
  const SlideList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SlideListState();
}

class _SlideListState extends ConsumerState<SlideList> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(SliderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          Get.to(() => AddSlider(), transition: Transition.fade);
        },
        child: const Icon(CupertinoIcons.add_circled),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      body: SafeArea(
          child: Column(
        children: [
          AnimationLimiter(
            child: ListView.builder(
                itemCount: controller.slider.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: SliderCard(
                          slider: controller.slider[index],
                        )),
                  );
                }),
          )
          // : Center(
          //     child: CircularProgressIndicator(
          //         color: AppColors.mainColor, strokeWidth: 1.5),
          //   )),
        ],
      )),
    );
  }
}
