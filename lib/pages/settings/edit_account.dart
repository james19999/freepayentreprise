import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/helper/local_storage.dart';
import 'package:freepayagency/pages/services/user_service.dart';
import 'package:freepayagency/pages/settings/setting_account.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CompteEdit extends ConsumerStatefulWidget {
  const CompteEdit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompteEditState();
}

class _CompteEditState extends ConsumerState<CompteEdit> {
  GlobalKey<FormState> _formk = GlobalKey<FormState>();
  TextEditingController _controllername =
      TextEditingController(text: localstorage.username);
  TextEditingController _controlleradresse =
      TextEditingController(text: localstorage.adress);
  TextEditingController _controllerraison =
      TextEditingController(text: localstorage.raison);
  TextEditingController _controllerquartier =
      TextEditingController(text: localstorage.quartier);
  TextEditingController _controlleremail =
      TextEditingController(text: localstorage.email);
  TextEditingController _controllerpassword =
      TextEditingController(text: localstorage.password);
  TextEditingController _controllerdescription =
      TextEditingController(text: localstorage.description);
  var _controllerphone = "";
  // bool obscur = true;
  bool isloade = false;
  final _obscur = StateProvider((ref) => true);
  File? _image;

  final picker = ImagePicker();
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  uploadImage() async {
    Dio dio = Dio();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.all(8.0),
          child: ZoomTapAnimation(
            child: Card(
              elevation: 3,
              child: Container(
                  height: 50,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formk.currentState!.validate()) {
                          var check = await UserService.UpdateCompay(
                            _controllername.text,
                            _controllerphone,
                            _controlleradresse.text,
                            _controlleremail.text,
                            _controllerraison.text,
                            _controllerdescription.text,
                            _controllerpassword.text,
                            _controllerquartier.text,
                          );

                          if (check == true) {
                            Toas.getSnackbarsucess(
                                appName, "Votre Compte à été bien  modifier. ");
                            Get.off(() => SettingAccount());
                          } else {
                            Toas.getSnackbarEror(appName, "Erreur ");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.mainColor,
                      ),
                      child: Text(
                        "Modifier".tr,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))),
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Modifier mon compte", style: StyleText),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                  child: Column(children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent.withOpacity(0.2),
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                          child: Image.network(
                        "${BaseImage}${localstorage.img}",
                        fit: BoxFit.cover,
                      ))),
                  radius: 50,
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  localstorage.phone,
                  style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 19,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
              ])),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Form(
                      key: _formk,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _controllername,
                            keyboardType: TextInputType.text,
                            // controller: _amount,
                            validator: (value) => value!.isEmpty
                                ? "Le nom de votre entreprise"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Nom de l'entreprise"),
                                suffixIcon: Icon(Icons.home),
                                isDense: true,
                                filled: true,
                                // fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _controlleradresse,
                            validator: (value) =>
                                value!.isEmpty ? "Adresse" : null,
                            decoration: InputDecoration(
                                label: Text("Adresse de l'entreprise"),
                                suffixIcon: Icon(Icons.location_city),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _controllerraison,
                            // validator: (value) =>
                            //     value!.isEmpty ? "Raison sociale" : null,
                            decoration: InputDecoration(
                                hintText: "Optionnel",
                                label: Text("Raison sociale"),
                                suffixIcon: Icon(Icons.block_flipped),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _controllerquartier,
                            validator: (value) =>
                                value!.isEmpty ? "Quartier" : null,
                            decoration: InputDecoration(
                                label: Text("Quartier"),
                                suffixIcon: Icon(Icons.home),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _controlleremail,
                            validator: (value) =>
                                value!.isEmpty ? "Email" : null,
                            decoration: InputDecoration(
                                label: Text("Email"),
                                suffixIcon: Icon(Icons.mail),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
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
                              isDense: true,
                              filled: true,
                              hintText: "Numéro de téléphone",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.0,
                                  )),
                            ),
                            onChanged: (phone) {
                              _controllerphone = phone.completeNumber;
                            },
                            onCountryChanged: (country) {
                              // print('Country changed to: ' + country.name);
                            },
                          ),
                          TextFormField(
                            readOnly: true,
                            obscureText: ref.watch(_obscur),
                            keyboardType: TextInputType.text,
                            controller: _controllerpassword,
                            validator: (value) =>
                                value!.isEmpty ? "Mot de passe" : null,
                            decoration: InputDecoration(
                                label: Text("Choisissez un  Mot de passe"),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      ref.watch(_obscur.notifier).state =
                                          !ref.watch(_obscur.notifier).state;
                                    },
                                    icon: Icon(
                                        color: AppColors.mainColor,
                                        ref.watch(_obscur)
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          TextFormField(
                            maxLength: 100,
                            minLines: 5,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            controller: _controllerdescription,
                            validator: (value) => value!.isEmpty
                                ? "Une petite description de votre entreprise"
                                : null,
                            decoration: InputDecoration(
                                label: Text("Une petite description "),
                                suffixIcon: Icon(Icons.description_outlined),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                          // InkWell(
                          //   onTap: () => _openImagePicker,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.transparent.withOpacity(0.2),
                          //         borderRadius: BorderRadius.circular(4)),
                          //     alignment: Alignment.center,
                          //     width: Get.width * 0.5,
                          //     height: Get.height * 0.18,
                          //     child: TextButton(
                          //         onPressed: _openImagePicker,
                          //         child: _buildImage()),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),
                          // Text("Logo/Image de couverture")
                        ],
                      )),
                ),
              )
            ]),
          ),
        ));
  }
}
