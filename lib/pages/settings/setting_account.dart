import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/carte/debit_cart.dart';
import 'package:freepayagency/pages/carte/validation_transaction_carte.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/controller/history_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/services/user_service.dart';
import 'package:freepayagency/pages/settings/edit_account.dart';
import 'package:freepayagency/pages/settings/edit_password_account.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingAccount extends ConsumerStatefulWidget {
  const SettingAccount({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingAccountState();
}

class _SettingAccountState extends ConsumerState<SettingAccount> {
  File? image;

  final picker = ImagePicker();
  final _picker = ImagePicker();
  Future<void> pickOne() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  List<dynamic> compte = [
    {
      "name": 'Modifier votre compte'.tr,
      "icon": Icon(CupertinoIcons.pencil),
      "path": Icon(
        size: 18,
        CupertinoIcons.right_chevron,
        color: AppColors.mainColor,
      ),
    },
    {
      "name": 'Modifier le mot de passe'.tr,
      "icon": Icon(CupertinoIcons.lock),
      "path": Icon(
        size: 18,
        CupertinoIcons.right_chevron,
        color: AppColors.mainColor,
      )
    },
    {
      "name": 'Notifications'.tr,
      "icon": Icon(Icons.notifications),
      "path": IconButton(
        onPressed: () {},
        icon: (Icon(size: 18, CupertinoIcons.right_chevron)),
        color: AppColors.mainColor,
      ),
    },
    {
      "name": 'Langue'.tr,
      "icon": Icon(Icons.translate_outlined),
      "path": Icon(
        size: 18,
        CupertinoIcons.right_chevron,
        color: AppColors.mainColor,
      )
    },
  ];
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(CartProviders);
    final controllers =ref.watch(HistoryProviders);


    {
      return Scaffold(
          drawer: DrawCostum(),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Paramètre du compte".tr, style: StyleText),
            elevation: 0,
            backgroundColor: AppColors.mainColor,
            actions: [
              IconButton(
                  onPressed: () async {
                    var check = await UserService.upadatecompanyimage(image!);
                    if (check == true) {
                      Toas.getSnackbarsucess(
                          appName, "Image du profil mise à jour".tr);
                    } else {
                      Toas.getSnackbarEror(appName, "Erreur".tr);
                    }
                  },
                  icon: Icon(Icons.save))
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                    child: Column(children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: image == null
                        ? InkWell(
                            onTap: () {
                              pickOne();
                            },
                            child: SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipOval(
                                    child: Image.network(
                                  "${BaseImage}${localstorage.img}",
                                  fit: BoxFit.cover,
                                ))),
                          )
                        : InkWell(
                            onTap: () {
                              pickOne();
                            },
                            child: SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipOval(
                                    child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ))),
                          ),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    localstorage.username,
                    style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 19,
                    ),
                  )
                ])),
                Row(
                  children: [
                    AnimationLimiter(
                      child: Expanded(
                        child: ListView.separated(
                          itemCount: compte.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1.2,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var cpt = compte[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ListTile(
                                    onTap: () {
                                      if (index == 0) {
                                        Get.to(() => CompteEdit(),
                                            transition: Transition.leftToRight);
                                      } else if (index == 1) {
                                        Get.to(() => EditPasswordAccount(),
                                            transition: Transition.leftToRight);
                                      } else if (index == 2) {}
                                    },
                                    title: Text(
                                      cpt['name'],
                                      style: TextStyle(
                                          fontFamily: "poppins",
                                          color: AppColors.mainColor),
                                    ),
                                    leading: cpt['icon'],
                                    trailing: cpt['path'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("${"Montant total des  cartes:".tr}  ${controllers.globalTotal} XOF ")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(" ${"Montant restant sur les  cartes:".tr}  ${controller.amounts} XOF ")),
                    ],
                  ),
                ),
              ]),
            ),
          ));
    }
  }
}
