import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/carte/create_cart.dart';
import 'package:freepayagency/pages/clients/show_client.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';

class ClientCard extends ConsumerWidget {
  final ClientModel clientModel;
  const ClientCard({super.key, required this.clientModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(ClientProviders);
    return FadeInAnimation(
        child: ListTile(
      onTap: () {
        Get.to(() => CreateCart(
              id: clientModel.id,
              name: clientModel.name,
            ));
      },
      leading: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          height: 50,
          width: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${clientModel.name}'.substring(0, 1),
              textAlign: TextAlign.center,
              style: StyleText,
            ),
          )),
      title: Text(
        clientModel.name.toUpperCase(),
        style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 13),
        maxLines: 1,
      ),
      subtitle: Text(
        clientModel.phone,
        style: TextStyle(
            overflow: TextOverflow.ellipsis, fontSize: 13, letterSpacing: 2),
        maxLines: 1,
      ),
      trailing: IconButton(
        onPressed: () {
          Get.to(() => ShowClient(client: clientModel),
              transition: Transition.fade);
        },
        icon: Icon(
          Icons.remove_red_eye,
          color: AppColors.mainColor,
        ),
      ),
    ));
  }
}
