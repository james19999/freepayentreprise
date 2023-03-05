import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/ecommer/order.dart';
import 'package:freepayagency/pages/models/ecommer/order_item.dart';
import 'package:freepayagency/pages/services/commande_service.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class OrderDetail extends ConsumerStatefulWidget {
  final Order order;
  const OrderDetail({super.key, required this.order});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDetailState();
}

class _OrderDetailState extends ConsumerState<OrderDetail> {
  List<Ordersitem> orderItems = [];
  var total;
  @override
  @override
  void initState() {
    super.initState();
    loader();
  }

  loader() async {
    orderItems = await CommandeService.getOrderItems(widget.order.id);
    total = orderItems.fold(
        0,
        (previousValue, element) =>
            (element.qty * element.product.price) + previousValue);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text(
          "Détails commandes",
          style: StyleText,
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Valider",
                style: StyleText.copyWith(color: AppColors.mainColor8_two),
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              children: [
                Text("Image"),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Text("Nom"),
                SizedBox(
                  width: Get.width * 0.34,
                ),
                Text("Qty"),
                SizedBox(
                  width: Get.width * 0.2,
                ),
                Text("Prix"),
              ],
            ),
            Divider(
              height: 1,
              indent: 1,
              endIndent: 1,
              color: AppColors.mainColor,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            orderItems.length > 0
                ? Expanded(
                    child: AnimationLimiter(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 6,
                              thickness: 1,
                              indent: 4,
                              endIndent: 4,
                            );
                          },
                          itemCount: orderItems.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var order = orderItems[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: Container(
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            ),
                                            height: 50,
                                            width: 50,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: Image.network(
                                                    "${BaseImages}${order.product.img}"))),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Expanded(
                                          child: Text(
                                            order.product.name,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            order.qty.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                            "${order.product.price.toString()} XOF .")
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                  )
                : Text("Commande en cours d'édition"),
            TotalLine("Mode de payement :", "Free pay"),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TotalLine("Status :", "En cours"),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TotalLine("Total :", total),
          ],
        ),
      )),
    );
  }

  Row TotalLine(title, desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Container(
            height: 30,
            width: 100,
            color: Colors.grey[300],
            child: Text(
              "${desc} XOF",
              style: StyleText,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  ListTile Contai(Ordersitem order) {
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          height: 50,
          width: 50,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Image.network("${BaseImages}${order.product.img}"))),
      title: Text(
        order.product.name,
        style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 13),
        maxLines: 1,
      ),
      subtitle: Text(order.qty.toString()),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(order.qty.toString()),
        Text(order.product.price.toString())
      ]),
    );
  }
}
