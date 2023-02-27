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

class EditClient extends ConsumerStatefulWidget {
  final ClientModel clientmodel;
  const EditClient({super.key, required this.clientmodel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditClientState();
}

class _EditClientState extends ConsumerState<EditClient> {
  GlobalKey<FormState> _formk = GlobalKey<FormState>();
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllerville = TextEditingController();
  TextEditingController _controlleradresse = TextEditingController();
  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerquartier = TextEditingController();
  TextEditingController _controlleridentifiant = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var _controllerphone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllername.text = widget.clientmodel.name;
    _controlleradresse.text = widget.clientmodel.adress;
    _controlleremail.text = widget.clientmodel.email;
    _controllerphone = widget.clientmodel.phone;
    _controllerville.text = widget.clientmodel.ville;
    _controllerquartier.text = widget.clientmodel.quartier;
    _controlleridentifiant.text = widget.clientmodel.identify;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ClientProviders);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: DrawCostum(),
        appBar: AppBar(
          title: Text('Ajouter un client'),
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
                          var client = ClientModel(
                            name: _controllername.text,
                            adress: _controlleradresse.text,
                            email: _controlleremail.text,
                            identify: _controlleridentifiant.text,
                            phone: _controllerphone,
                            quartier: _controllerquartier.text,
                            ville: _controllerville.text,
                          );
                          var chek = await controller.EditClient(
                              client, widget.clientmodel.id);
                          if (chek == true) {
                            Toas.getSnackbarsucess(
                                appName, "Le client à été bien modifier");
                            Get.to(() => ClientList(),
                                transition: Transition.fade);
                            controller.getclients();
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
                            controller: _controllername,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer le nom"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Nom"),
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
                                hintText: "Nom et prénom du client",
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
                                ? "Veuillez entrer la ville"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Ville"),
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
                                hintText: "Ville  du client",
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
                                ? "Veuillez entrer l 'adresse"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Adresse"),
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
                                hintText: "Adresse du client",
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
                                ? "Veuillez entrer l'email"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Email"),
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
                                hintText: "Email",
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
                                ? "Veuillez entrer le quartier"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Quartier"),
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
                                hintText: "Quartier",
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            obscureText: true,
                            readOnly: true,
                            controller: _controlleridentifiant,
                            validator: (value) => value!.isEmpty
                                ? "Veuillez entrer un identifiant"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Identifiant"),
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
                                hintText: "Choisissez un identifiant",
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          IntlPhoneField(
                            initialCountryCode: 'TG',
                            searchText: "Rechercher votre pays",
                            invalidNumberMessage:
                                "Numéro de téléphone invalide",
                            decoration: InputDecoration(
                              label: Text("Téléphone"),
                              isDense: true,
                              hintText: "Numéro de téléphone",
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
