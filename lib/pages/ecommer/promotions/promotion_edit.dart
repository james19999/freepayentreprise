import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/promotion_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/ecommer/promotions/promotion_list.dart';
import 'package:freepayagency/pages/models/ecommer/promotion.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPromot extends ConsumerStatefulWidget {
  final Promotion promotion;
  const EditPromot({super.key, required this.promotion});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPromotState();
}

class _EditPromotState extends ConsumerState<EditPromot> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllerPriceNormal = TextEditingController();
  TextEditingController _controllerPromoPrice = TextEditingController();
  TextEditingController _controllerDateStart = TextEditingController();
  TextEditingController _controllerDateEnde = TextEditingController();
  var dateStart = '';
  var dateEnde = '';
  File? _image;

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

  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _controllerDateStart.text = dateStart;
    _controllerDateEnde.text = dateEnde;
    _controllername.text = widget.promotion.title;
    _controllerPriceNormal.text = widget.promotion.normal_price;
    _controllerPromoPrice.text = widget.promotion.promot_price;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(PromotionProvider);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Modifier une promotion"),
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
                      if (_key.currentState!.validate()) {
                        if (int.parse(_controllerPromoPrice.text) >
                            int.parse(_controllerPriceNormal.text)) {
                          Toas.getSnackbarEror(appName,
                              "Le prix promotion ne dois pas être supérieur aux prix normal.");
                        } else {
                          var check = await controller.AddPromotion(
                              _image!,
                              _controllerPriceNormal.text,
                              _controllerPromoPrice.text,
                              dateStart,
                              dateEnde,
                              _controllername.text);
                          if (check == true) {
                            Toas.getSnackbarsucess(appName, "Catégorie créer");
                            controller.getPromotion();
                            Get.off(() => PromotionList());
                          } else {
                            Toas.getSnackbarEror(appName,
                                "Erreur de créaction vérifier si la catégorie n'existe pas.");
                          }
                        }
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Enregistrer ",
                      style: StyleText.copyWith(color: Colors.white),
                    ))),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                  key: _key,
                  child: Column(children: [
                    TextFormField(
                      controller: _controllername,
                      validator: (value) => value!.isEmpty
                          ? "Veuillez entrer le nom du produit"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Nom du produit"),
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
                          hintText: "Nom du produit en promotion",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerPriceNormal,
                      validator: (value) => value!.isEmpty
                          ? "Veuillez entrer le normal du produit"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Le prix normal du produit"),
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
                          hintText: "Le prix normal du produit",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerPromoPrice,
                      validator: (value) => value!.isEmpty
                          ? "Veuillez entrer le prix promot"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Le prix promot"),
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
                          hintText: "Le prix promot",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: _controllerDateStart,
                      decoration: InputDecoration(
                          hintText: '$dateStart ',
                          labelText: 'Date Début ',
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
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onTap: () async {
                        var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          dateStart = formattedDate;
                          print(dateStart);
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: _controllerDateEnde,
                      decoration: InputDecoration(
                          hintText: '$dateEnde ',
                          labelText: 'Date Fin ',
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
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onTap: () async {
                        var pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          dateEnde = formattedDate;
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    InkWell(
                      onTap: () => _openImagePicker,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.7, color: AppColors.mainColor),
                            color: Colors.transparent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        width: Get.width,
                        height: Get.height * 0.18,
                        child: TextButton(
                            onPressed: _openImagePicker, child: _buildImage()),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text("Image")
                  ]))
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildImage() {
    if (_image == null) {
      return Icon(
        Icons.photo_camera,
        color: Colors.grey[200],
        size: 50,
      );
    } else {
      return Image.file(_image!, fit: BoxFit.cover);
    }
  }
}
