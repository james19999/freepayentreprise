import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/carte/list_cart.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/cart_client.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CreateCart extends ConsumerStatefulWidget {
  final dynamic id;
  final dynamic name;
  const CreateCart({super.key, required this.id, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCartState();
}

class _CreateCartState extends ConsumerState<CreateCart> {
  GlobalKey<FormState> _formk = GlobalKey<FormState>();
  TextEditingController _controlleramount = TextEditingController();
  TextEditingController _controllerclient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ClientProviders);
    final controllercarte = ref.watch(CartProviders);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: DrawCostum(),
        appBar: AppBar(
          title: Text('Ajouter une carte'),
          centerTitle: true,
        ),
        bottomSheet: Container(
            height: Get.height * 0.11,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton.icon(
                      onPressed: () async {
                        if (_formk.currentState!.validate()) {
                          var carts = Cart(
                            clientId: widget.id,
                            amount: _controlleramount.text,
                          );
                          var chek = await controllercarte.CreateCarte(carts);
                          if (chek == true) {
                            Toas.getSnackbarsucess(
                                appName, "La carte à été bien ajouter");
                            Get.off(() => CarteList(),
                                transition: Transition.fade);
                            controllercarte.getcartcompany();
                          }
                        } else {}
                      },
                      icon: Icon(
                        Icons.outbound_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Enregistrer ",
                        style: StyleText.copyWith(color: Colors.white),
                      ))),
            )),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                      key: _formk,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _controlleramount,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer le montant"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Montant"),
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
                                hintText: "Montant",
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          // Text(widget.clientModel.id),
                          // Text(widget.clientModel.name),

                          TextFormField(
                            onTap: () {
                              Get.to(() => ClientList());
                            },
                            onChanged: (value) {},
                            readOnly: true,
                            decoration: InputDecoration(
                                helperText: "Sélectionnez un client",
                                label: Text(widget.id.toString() == null
                                    ? "Sélectionnez un client"
                                    : widget.name.toString()),
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
                                hintText: "Sélectionnez un cient",
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),

                          Text(widget.name.toString())
                        ],
                      ))
                ],
              ),
            )));
  }
}
