import 'package:flutter/material.dart';
import 'package:freepayagency/pages/carte/credite_cart.dart';
import 'package:freepayagency/pages/carte/debit_cart.dart';
import 'package:freepayagency/pages/carte/list_cart.dart';
import 'package:freepayagency/pages/carte/validation_transaction_carte.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/user_controller.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/ecommer/commande/commande_list.dart';
import 'package:freepayagency/pages/ecommer/product/product_list.dart';
import 'package:freepayagency/pages/ecommer/promotions/promotion_list.dart';
import 'package:freepayagency/pages/ecommer/pub/pub_list.dart';
import 'package:freepayagency/pages/ecommer/slider/slider_list.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/home/home.dart';
import 'package:freepayagency/pages/settings/setting_account.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:freepayagency/pages/wideget/listtile.dart';
import 'package:freepayagency/splashlogout.dart';
import 'package:get/get.dart';

Drawer DrawCostum() {
  return Drawer(
    child: 
     localstorage.status==1?
    ListView(
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
                        child: Image.network(
                      "${BaseImage}${localstorage.img}",
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
            "Tableau de bord".tr, Icons.dashboard, Icons.arrow_forward_ios, StyleText,
            () {
          Get.back(closeOverlays: false);
          Get.to(() => Home(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTileCustom("Clients".tr, Icons.group, Icons.arrow_forward_ios,
            StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => ClientList(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
            ListTileCustom(
                "Free Pay Carte".tr,
                Icons.card_giftcard,
                Icons.arrow_forward_ios,
                StyleText.copyWith(fontSize: 14), () {
              Get.back(closeOverlays: false);

              Get.to(() => CarteList(), transition: Transition.leftToRight);
            }),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
              ListTileCustom("Crédité".tr, Icons.money, Icons.arrow_forward_ios,
                  StyleText.copyWith(fontSize: 14), () {
                Get.back(closeOverlays: false);

                Get.to(() => CreditCart(),
                    transition: Transition.leftToRight);
              }),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTileCustom(
                    "Débité".tr,
                    Icons.monetization_on_outlined,
                    Icons.arrow_forward_ios,
                    StyleText.copyWith(fontSize: 14), () {
                  Get.back(closeOverlays: false);

                  Get.to(() => DebiteCarte(),
                      transition: Transition.leftToRight);
                }),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTileCustom(
                    "Valider une transaction".tr,
                    Icons.check_circle_outline,
                    Icons.arrow_forward_ios,
                    StyleText.copyWith(fontSize: 14), () {
                  Get.back(closeOverlays: false);

                  Get.to(() => ValidationTransaction(),
                      transition: Transition.leftToRight);
                }),

        Divider(
          height: 1,
          thickness: 1,
        ),

        // ExpansionTile(
        //   leading: Icon(
        //     Icons.shopping_basket_outlined,
        //     color: AppColors.mainColor,
        //   ),
        //   trailing: Icon(
        //     Icons.keyboard_arrow_down_outlined,
        //     size: 40,
        //     color: Colors.grey,
        //   ),
        //   title: Text(
        //     "E-Commerce".tr,
        //     style: StyleText.copyWith(fontSize: 14),
        //   ),
        //   children: [
        //     Column(
        //       children: [
        //         ListTileCustom(
        //             "Produits".tr,
        //             Icons.production_quantity_limits,
        //             Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => ProductList(),
        //               transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //         ListTileCustom("Catégories".tr, Icons.tag, Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => CategoryList(),
        //               transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //         ListTileCustom(
        //             "Commandes".tr,
        //             Icons.business_center,
        //             Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => CommandeList(),
        //               transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //         ListTileCustom("Slider".tr, Icons.image, Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => SlideList(), transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //         ListTileCustom(
        //             "Promotions/produits".tr,
        //             Icons.campaign,
        //             Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => PromotionList(),
        //               transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //         ListTileCustom(
        //             "Produits en avant".tr,
        //             Icons.propane_outlined,
        //             Icons.arrow_forward_ios,
        //             StyleText.copyWith(fontSize: 14), () {
        //           Get.back(closeOverlays: false);

        //           Get.to(() => PubList(), transition: Transition.leftToRight);
        //         }),
        //         Divider(
        //           height: 0,
        //           thickness: 1,
        //         ),
        //       ],
        //     )
        //   ],
        // ),

        ListTileCustom("Paramètre du compte".tr, Icons.settings,
            Icons.arrow_forward_ios, StyleText.copyWith(fontSize: 14), () {
          Get.back(closeOverlays: false);

          Get.to(() => SettingAccount(), transition: Transition.leftToRight);
        }),
        Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
            onTap: () {
              Get.showSnackbar(GetSnackBar(
                title: "",
                message: "",
                messageText: Column(
                  children: [
                    Container(
                      width: Get.width * 0.6,
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            Get.updateLocale(Locale('fr', 'FR'));
                            Get.back();

                          },
                          title: Text("Français".tr),
                          trailing: Image.asset(
                            fr,
                            width: 50,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: Get.width * 0.6,
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            Get.updateLocale(Locale('en', 'US'));
                            Get.back();
                          },
                          title: Text("Anglais".tr),
                          trailing: Image.asset(
                            en,
                            width: 50,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                backgroundColor: Colors.transparent,
                onTap: (snack) {
                  Get.back();
                },
              ));
            },
            leading: Icon(
              Icons.translate_rounded,
              color: AppColors.mainColor,
            ),
            title: Text(
              "Langue".tr,
              style: StyleText.copyWith(fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios)),
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
                title: "Entreprise".tr,
                middleText: 'Voulez-vous vraiment vous déconnectez'.tr,
                textCancel: "Non".tr,
                textConfirm: "Oui".tr,
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
            'Déconnexion'.tr,
            style: StyleText.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ):Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text("Contactez  +288 93 26 60 04 / +228 92 21 25 30 pour valider votre compte".tr)),
    ),
  );
}
