import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/clients/client_list.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/client_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddClient extends ConsumerStatefulWidget {
  const AddClient({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddClientState();
}

class _AddClientState extends ConsumerState<AddClient> {
  GlobalKey<FormState> _formk = GlobalKey<FormState>();
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllerville = TextEditingController();
  TextEditingController _controlleradresse = TextEditingController();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerquartier = TextEditingController();
  TextEditingController _controlleridentifiant = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var _controllerphone;
  bool obscur = true;
   bool isloade=false;
  
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ClientProviders);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: DrawCostum(),
        appBar: AppBar(
          title: Text('Ajouter un client'.tr),
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
                           setState(() {
                             isloade=true;
                           });
                          var client = ClientModel(
                            name: _controllername.text,
                            adress: _controlleradresse.text,
                            email: _controlleremail.text.trim(),
                            identify: _controlleridentifiant.text.trim(),
                            phone: _controllerphone,
                            quartier: _controllerquartier.text,
                            ville: _controllerville.text,
                          );
                          var chek = await controller.AddClient(client);
                          if (chek == true) {
                            Toas.getSnackbarsucess(
                                appName, "Le client à été bien ajouter".tr);
                            Get.off(() => ClientList(),
                                transition: Transition.fade);
                            controller.getclients();
                          }
                        } else {
                           setState(() {
                             isloade=false;
                           });
                        }
                      },
                      icon: Icon(
                        Icons.outbound_outlined,
                        color: Colors.white,
                      ),
                      label: 
                         isloade==false?
                       Text(
                        "Enregistrer".tr,
                        style: StyleText.copyWith(color: Colors.white),
                      ):CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,))),
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
                            controller: _controllername,
                            validator: (value) => value!.isEmpty
                                ? "Nom et prénom du client".tr
                                : null,
                            decoration: InputDecoration(
                                label: Text("Nom et prénom du client".tr),
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
                                hintText: "Nom et prénom du client".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            controller: _controllerville,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer la ville".tr
                                : null,
                            decoration: InputDecoration(
                                label: Text("Ville".tr),
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
                                hintText: "Ville  du client".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            controller: _controlleradresse,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer l'adresse".tr
                                : null,
                            decoration: InputDecoration(
                                label: Text("Adresse".tr),
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
                                hintText: "Adresse du client".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            controller: _controlleremail,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer l'email".tr
                                : null,
                            decoration: InputDecoration(
                                label: Text("Email".tr),
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
                                hintText: "Email".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            controller: _controllerquartier,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer le quartier".tr
                                : null,
                            decoration: InputDecoration(
                                label: Text("Quartier".tr),
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
                                hintText: "Quartier".tr,
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            controller: _controlleridentifiant,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer un identifiant".tr
                                : null,
                            obscureText: obscur,
                            decoration: InputDecoration(
                                label: Text("Identifiant".tr),
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
                                hintText: "Choisissez un identifiant".tr,
                                isDense: true,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscur = !obscur;
                                      });
                                    },
                                    icon: Icon(
                                        color: AppColors.mainColor,
                                        obscur
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          IntlPhoneField(
                            initialCountryCode: 'TG',
                            searchText: "Rechercher votre pays".tr,
                            invalidNumberMessage:
                                "Numéro de téléphone invalide".tr,
                            decoration: InputDecoration(
                              label: Text("Téléphone".tr),
                              isDense: true,
                              hintText: "Numéro de téléphone".tr,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              ),
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
                            ),
                            onChanged: (phone) {
                              _controllerphone = phone.completeNumber;
                            },
                            onCountryChanged: (country) {
                              // print('Country changed to: ' + country.name);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}
