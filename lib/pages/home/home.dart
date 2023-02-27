import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: () async {},
            child: const Icon(Icons.refresh),
          ),
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            actions: [
              // IconButton(
              //     onPressed: () {
              //       Get.to(() => CompanyList(), transition: Transition.fade);
              //     },
              //     icon: Icon(
              //       Icons.remove_red_eye_sharp,
              //       color: Colors.white,
              //     ))
            ],
            elevation: 0,
            title: Text(
              "Free Pay  Dashboard",
              style: StyleText,
            ),
            centerTitle: true,
          ),
          drawer: DrawCostum(),
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: Get.height * 0.18,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.group,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Clients",
                                            style: StyleText.copyWith(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text(
                                        "50000 ",
                                        style: StyleText.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.card_giftcard,
                                            color: Colors.white,
                                          ),
                                          Text("Free Pay Carte",
                                              style: StyleText.copyWith(
                                                  color: Colors.white,
                                                  fontSize: fontsizes)),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text("5000000 ",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: fontsizes)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor8_two,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Dépense",
                                        style: StyleText.copyWith(
                                            color: Colors.white,
                                            fontSize: fontsizes),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text("70000 F",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: fontsizes)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: Get.height * 0.18,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.group,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Actif Carte",
                                            style: StyleText.copyWith(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text(
                                        "50000 ",
                                        style: StyleText.copyWith(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor8_two,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.card_membership_sharp,
                                            color: Colors.white,
                                          ),
                                          Text("Carte inactif",
                                              style: StyleText.copyWith(
                                                  color: Colors.white,
                                                  fontSize: fontsizes)),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text("5000000 ",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: fontsizes)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor8_two,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Dépense",
                                        style: StyleText.copyWith(
                                            color: Colors.white,
                                            fontSize: fontsizes),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text("70000 F",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: fontsizes)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Voulez vous fermer l'application"),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Oui'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('Non'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        });
  }
}
