import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/pub_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/add_category.dart';
import 'package:freepayagency/pages/ecommer/pub/add_pub.dart';
import 'package:freepayagency/pages/ecommer/pub/pub_card.dart';
import 'package:get/get.dart';

class PubList extends ConsumerStatefulWidget {
  const PubList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PubListState();
}

class _PubListState extends ConsumerState<PubList> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(PubProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Produit en avant"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          Get.to(() => AddPub(), transition: Transition.fade);
        },
        child: const Icon(CupertinoIcons.add_circled),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          controller.pubs.isNotEmpty
              ? AnimationLimiter(
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: controller.pubs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: PubCard(
                                  pub: controller.pubs[index],
                                )),
                          );
                        }),
                  ),
                )
              : Text("Aucun produit mise ne avant")
        ],
      )),
    );
  }
}
