import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/controller/pub_controller.dart';
import 'package:freepayagency/pages/ecommer/pub/edit_pub.dart';
import 'package:freepayagency/pages/models/ecommer/pub.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class PubCard extends ConsumerWidget {
  final Pubs pub;
  const PubCard({super.key, required this.pub});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(PubProvider);

    return FadeInAnimation(
        child: Padding(
            padding: const EdgeInsets.only(left: 8.9, right: 8.9, top: 8.0),
            child: InkWell(
              onTap: () {
                Get.to(() => EditPub(
                      pubs: pub,
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(),
                  height: Get.height * 0.2,
                  width: Get.width,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Image.network(
                        "${BaseImagepub}${pub.img}",
                        fit: BoxFit.cover,
                      ))),
            )));
  }
}
