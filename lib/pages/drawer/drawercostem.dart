import 'package:flutter/material.dart';
import 'package:freepayagency/pages/carte/credite_cart.dart';
import 'package:freepayagency/pages/carte/debit_cart.dart';
import 'package:freepayagency/pages/carte/list_cart.dart';
import 'package:freepayagency/pages/carte/validation_transaction_carte.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/user_controller.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/home/home.dart';
import 'package:freepayagency/pages/login/login.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/wideget/listtile.dart';
import 'package:freepayagency/splashlogout.dart';
import 'package:get/get.dart';

Drawer DrawCostum() {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipOval(
                        child: Image.asset(
                      logo,
                      fit: BoxFit.cover,
                    ))),
              ),
              SizedBox(
                height: Get.height * 0.012,
              ),
              Text(
                localstorage.username,
                style: TextStyle(color: AppColors.mainColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // ListTile(
        //   title: const Text('Item 1'),
        //   onTap: () {},
        // ),
        ListTileCustom(
            "Dashboard", Icons.dashboard, Icons.arrow_forward_ios, StyleText,
            () {
          Get.back(closeOverlays: false);
          Get.to(() => Home(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Client", Icons.group, Icons.arrow_forward_ios,
            StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => ClientList(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),

        ListTileCustom("Free Pay Carte", Icons.card_giftcard,
            Icons.arrow_forward_ios, StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => CarteList(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Crédité", Icons.money, Icons.arrow_forward_ios,
            StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => CreditCart(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Débité", Icons.monetization_on_outlined,
            Icons.arrow_forward_ios, StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => DebiteCarte(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Validé une transaction", Icons.check_circle_outline,
            Icons.arrow_forward_ios, StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => ValidationTransaction(),
              transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Paramètre du compte", Icons.settings,
            Icons.arrow_forward_ios, StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          // Get.to(() => ValidationTransaction(),
          //     transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.logout_outlined,
            size: iconsizes,
            color: AppColors.mainColor,
          ),
          onTap: () async {
            Get.defaultDialog(
                title: "Agent",
                middleText: 'Voulez-vous vraiment vous déconnectez',
                textCancel: "Non",
                textConfirm: "Oui",
                confirmTextColor: Colors.white,
                cancelTextColor: AppColors.mainColor,
                buttonColor: AppColors.mainColor,
                radius: 1.0,
                onConfirm: () async {
                  var decon = await UserCostumerController.LogoutUser();
                  if (decon == true) {
                    Get.offAll(() => Splashlogout(),
                        transition: Transition.zoom);
                  }
                },
                onCancel: () => {});
          },
          title: Text(
            'Déconnexion',
            style: StyleText.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
