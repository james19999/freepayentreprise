import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/carte/list_cart.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/history_controller.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/helper/date_convert.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/history/history_list.dart';
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
    final controller =ref.watch(HistoryProviders);
    final controllerclient =ref.watch(ClientProviders);
    final controllercart =ref.watch(CartProviders);
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: () async {
              controller.getallhistoryMethode();
            },
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
              "Free Pay  tableau de bord".tr,
              style: StyleText,
            ),
            centerTitle: true,
          ),
          drawer: DrawCostum(),
          body:
        localstorage.status==1?
          
           SafeArea(
            child: 
            
            Column(
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
                                child: InkWell(
                                  onTap: () {
                                    Get.to(()=>ClientList(),transition: Transition.fade);
                                  },
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
                                              "Clients".tr,
                                              style: StyleText.copyWith(
                                               fontSize: 15,
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
                                        controllerclient.clienttable.isNotEmpty?
                                        Text(
                                          "${controllerclient.clienttable.length ?? ""}",
                                          style: StyleText.copyWith(
                                              color: Colors.white),
                                        ):Text("0"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoomTapAnimation(
                                child: InkWell(
                                   onTap: () {
                                    Get.to(()=>CarteList(),transition: Transition.fade);
                                     
                                   },
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
                                            Text("Free Pay Carte".tr,
                                                style: StyleText.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 15,)),
                                          ],
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.white,
                                          indent: 9,
                                          endIndent: 9,
                                        ),
                                         controllercart.cartes.isNotEmpty?
                                        Text("${controllercart.cartes.length ?? ""}",
                                            style: StyleText.copyWith(
                                                color: Colors.white,
                                                fontSize: 15,)):Text("0"),
                                      ],
                                    ),
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
                                        "Active carte".tr,
                                        style: StyleText.copyWith(
                                            color: Colors.white,
                                            fontSize: 15,),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      controllercart.activecarte!=null?
                                      Text("${controllercart.activecarte.length?? ""}",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: 15,)):Text("0"),
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
                                            Icons.monetization_on_rounded,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Revenue du jour".tr,
                                            style: StyleText.copyWith(
                                               fontSize: 15,
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
                                        "${controller.todayTotal ?? ""} XOF",
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
                                            Icons.monetization_on_rounded,
                                            color: Colors.white,
                                          ),
                                          Text("Revenue de la semaine".tr,
                                              style: StyleText.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15,)),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text(  "${controller.weekTotal ?? ""} XOF",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: 15,)),
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
                                            Icons.monetization_on_rounded,
                                            color: Colors.white,
                                          ),
                                          Text("Revenue du mois".tr,
                                              style: StyleText.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15,)),
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.white,
                                        indent: 9,
                                        endIndent: 9,
                                      ),
                                      Text("${controller.mounthTotal ?? ""} XOF",
                                          style: StyleText.copyWith(
                                              color: Colors.white,
                                              fontSize: 15,)),
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
                ListTile(
                   onTap: () {
                     Get.to(()=>HistoryTransfert(),transition: Transition.fade);
                   },
                  title: Text("Transaction de la journée".tr,style: StyleText.copyWith(fontSize: 13),),trailing: Text("Voir l'historique".tr),),
                 Expanded(
                   child: 
                  controller.Historyday.isNotEmpty?
                   
                   ListView.builder(
                     shrinkWrap: true,
                     itemCount: controller.Historyday.length,
                    itemBuilder: (context, index) {
                      return ListTile(title:
                       Text("${controller.Historyday[index].amount} XOF"),
                       subtitle: Text("${controller.Historyday[index].cartNumber}"),
                       trailing: Text(DateConverter.formatDate(controller.Historyday[index].createdAt)),
                       
                       );
                   },) :Center(child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      //  CircularProgressIndicator(strokeWidth: 1.5,),
                       SizedBox(height: Get.height *0.02,),
                       Text("Aucune transaction effectuée".tr)
                     ],
                   ) ,),
                 )
              ],
            ),
          ) :Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${"Bienvenue".tr} ${localstorage.username}"),
                SizedBox(height: Get.height *0.03,),
                Text("Contactez  +288 93 26 60 04 / +228 92 21 25 30 pour valider votre compte pour profiter de notre service.".tr),
              ],
            )),
          ),
        ),
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Voulez vous fermer l'application ?".tr),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Oui'.tr),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('Non'.tr),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        });
  }
}
