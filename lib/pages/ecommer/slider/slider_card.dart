import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/controller/slider_controller.dart';
import 'package:freepayagency/pages/ecommer/product/product_detail.dart';
import 'package:freepayagency/pages/ecommer/product/product_edit.dart';
import 'package:freepayagency/pages/ecommer/slider/edit_slider.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/models/ecommer/slider.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class SliderCard extends ConsumerWidget {
  final Sliders slider;
  const SliderCard({super.key, required this.slider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(SliderProvider);
    return FadeInAnimation(
        child: Padding(
            padding: const EdgeInsets.only(left: 8.9, right: 8.9, top: 8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => EditSlider(
                      slider: slider,
                    ));
              },
              child: Container(
                color: Colors.white,
                height: Get.height * 0.2,
                width: Get.width,
                child: Row(children: [
                  Container(
                      decoration: BoxDecoration(),
                      height: Get.height * 0.2,
                      width: Get.width * 0.5,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Image.network(
                            "${BaseImages}${slider.img}",
                            fit: BoxFit.cover,
                          ))),
                  Container(
                      decoration: BoxDecoration(),
                      height: Get.height * 0.2,
                      width: Get.width * 0.3,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            slider.description,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 4,
                          ))),
                ]),
              ),
            )));
  }
}
