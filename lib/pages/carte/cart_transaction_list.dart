import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/carte/carte_transaction_widget.dart';
import 'package:freepayagency/pages/clients/widget_cart_listsyle.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/models/cart_client.dart';
import 'package:freepayagency/pages/models/transaction.dart';
import 'package:freepayagency/pages/services/transaction_service.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class Transactionlist extends ConsumerStatefulWidget {
  final Cart cart;
  const Transactionlist({super.key, required this.cart});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionlistState();
}

class _TransactionlistState extends ConsumerState<Transactionlist> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader();
  }

  loader() async {
    transactions = await Transactionservice.getalltransaction(widget.cart.code);
    setState(() {});
  }

  Widget build(BuildContext context) {
    final controller = ref.watch(CartProviders);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Transaction"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
               Get.showSnackbar(GetSnackBar(
                    message: "Voulez-vous supprimé?    Non",
                    title: "${appName}",
                    isDismissible: true,
                    onTap: (snack) {
                      Get.back();
                    },
                    mainButton: IconButton(
                        onPressed: () async {
                        await  controller.DeleteCart(widget.cart.code);
                        controller.getcartcompany();
                          Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        )),
                  ));
            }, icon: Icon(Icons.delete ,color: Colors.red,))
          ],
          bottom: TabBar(
            indicatorColor: AppColors.mainColor,
            tabs: [
              Tab(
                child: Text(
                  "Détails",
                  style: StyleText.copyWith(fontSize: fontsizes),
                ),
              ),
              Tab(
                child: Text(
                  "Transaction",
                  style: StyleText.copyWith(fontSize: fontsizes),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text(
                    "Info personnelle.",
                    style: StyleText.copyWith(
                      fontSize: fontsizes,
                    ),
                  ),
                  Listilinfo(
                      "Nom", "${widget.cart.client!.name} .".toUpperCase()),
                  Listilinfo("Téléphone",
                      "${widget.cart.client!.phone} .".toUpperCase()),
                  Listilinfo(
                      "Ville", "${widget.cart.client!.ville} .".toUpperCase()),
                  Listilinfo("Adresse",
                      "${widget.cart.client!.adress} .".toUpperCase()),
                  Listilinfo("Email", "${widget.cart.client!.email} ."),
                  Listilinfo("Quartier", "${widget.cart.client!.quartier} ."),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: AppColors.mainColor,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text(
                    "Info de la carte.",
                    style: StyleText.copyWith(fontSize: fontsizes),
                  ),
                  ListTile(
                    title: Text("Montant: ${widget.cart.amount} XOF"),
                    subtitle: Text("Numéro: ${widget.cart.code}"),
                    trailing: Text(
                        widget.cart.status == 1 ? "Activé" : "Désactivé",
                        style: TextStyle(
                            color: widget.cart.status == 1
                                ? Colors.green
                                : Colors.red)),
                  ),
                  ListTile(
                    title: Text("Date: ${widget.cart.created}"),
                    trailing: IconButton(
                        onPressed: () async {
                          await controller.ActivDesactiveCart(widget.cart.code);

                          controller.getcartcompany();
                        },
                        icon: widget.cart.status == 1
                            ? Icon(
                                Icons.lock_open,
                                color: Colors.green,
                              )
                            : Icon(Icons.lock, color: Colors.red)),
                  ),
                ],
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              transactions.length > 0
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: transactions.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: CardTransaction(
                                      transaction: transactions[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
                  : Center(
                      child: Text(
                      "Aucune transaction n'à été effectuer avec cette carte.",
                      textAlign: TextAlign.center,
                    )),
            ]),
          ],
        ),
      ),
    );
  }
}
