import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/clients/add_client.dart';
import 'package:freepayagency/pages/clients/client_card.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/services/client_service.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';

class ClientList extends ConsumerStatefulWidget {
  const ClientList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientListState();
}

class _ClientListState extends ConsumerState<ClientList> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ClientProviders);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () async {
          controller.getclients();
        },
        child: const Icon(Icons.refresh),
      ),
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text('Clients'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddClient(), transition: Transition.fade);
              },
              icon: Icon(
                Icons.add,
                size: iconsizes,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
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
                  hintText: "Rechercher un client",
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.search,
                    size: iconsizes,
                  ),
                  // suffixIcon: _textEditingController.text.length > 0
                  //     ? IconButton(
                  //         onPressed: () {
                  //           _textEditingController.clear();
                  //         },
                  //         icon: Icon(Icons.clear))
                  //     : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
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
                                      child: ClientCard(
                                        clientModel: controller
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
