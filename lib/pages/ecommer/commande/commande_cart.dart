import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/ecommer/commande/order_detail.dart';
import 'package:freepayagency/pages/models/ecommer/order.dart';
import 'package:get/get.dart';

class CommandeCard extends ConsumerWidget {
  final Order order;
  const CommandeCard({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => OrderDetail(
                order: order,
              ));
        },
        child: Container(
          height: Get.height * 0.4,
          color: Colors.white,
          child: Column(children: [
            RowLine("Nom :", order.client.name),
            RowLine("Téléphone :", order.client.phone),
            RowLine("Ville :", order.client.city),
            RowLine("Adresse :", order.client.adress),
            RowLine("Quartier :", order.client.quartier),
          ]),
        ),
      ),
    );
  }

  ListTile RowLine(title, desc) {
    return ListTile(
      title: Text(title),
      trailing: Text(desc),
      minVerticalPadding: 0.0,
    );
  }
}
