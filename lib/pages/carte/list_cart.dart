import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/carte/create_cart.dart';
import 'package:freepayagency/pages/carte/widget_cart.dart';
import 'package:freepayagency/pages/clients/add_client.dart';
import 'package:freepayagency/pages/clients/client_card.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/models/transaction.dart';
import 'package:freepayagency/pages/services/client_service.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';

class CarteList extends ConsumerStatefulWidget {
  const CarteList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarteListState();
}

class _CarteListState extends ConsumerState<CarteList> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(CartProviders);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          controller.getcartcompany();
        },
        child: const Icon(Icons.refresh),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text('Free Pay Cart'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateCart(id: '', name: ''),
                    transition: Transition.fade);
              },
              icon: Icon(
                Icons.add,
                size: iconsizes,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (value) {
                  controller.filterCrop(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.lerp(
                        EdgeInsets.all(5.0), EdgeInsets.all(8.0), 1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: AppColors.mainColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: AppColors.mainColor,
                      ),
                    ),
                    hintText: "Entrer le nom du client .",
                    isDense: true,
                    suffixIcon: Icon(
                      Icons.search,
                      size: iconsizes,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Expanded(
              child: _textEditingController.text.isNotEmpty &&
                      controller.filteredTempCropList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search_off,
                                size: 80,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Aucune résultat pour votre recherche',
                                  style: TextStyle(
                                      fontSize: fontsizes,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : controller.filteredTempCropList.isNotEmpty
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
                              itemCount: controller.filteredTempCropList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: CartCard(
                                        cart: controller
                                            .filteredTempCropList[index],
                                      )),
                                );
                              }),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor, strokeWidth: 2),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
