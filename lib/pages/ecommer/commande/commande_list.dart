import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/order_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/commande/commande_cart.dart';
import 'package:get/get.dart';

class CommandeList extends ConsumerStatefulWidget {
  const CommandeList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommandeListState();
}

class _CommandeListState extends ConsumerState<CommandeList> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(OrderProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          controller.getOrder();
        },
        child: const Icon(Icons.refresh),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Liste des commandes"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: controller.order.isNotEmpty
                ? AnimationLimiter(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            thickness: 1,
                            indent: 4,
                            endIndent: 4,
                          );
                        },
                        itemCount: controller.order.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: CommandeCard(
                                  order: controller.order[index],
                                )),
                          );
                        }),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            strokeWidth: 1.5, color: AppColors.mainColor),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text("Vous n'avez pas de commande disponible.")
                      ],
                    ),
                  ),
          )
        ],
      )),
    );
  }
}
