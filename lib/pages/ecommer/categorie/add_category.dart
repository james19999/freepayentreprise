import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _controllername = TextEditingController();

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
  Widget build(BuildContext context) {
    final controller = ref.watch(CategoryProviders);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Ajouter une catégorie"),
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
                        var check = await controller.uploadImage(
                            _controllername.text, _image!);
                        if (check == true) {
                          Toas.getSnackbarsucess(appName, "Catégorie créer");
                          controller.getCategorys();
                          Get.off(() => CategoryList());
                        } else {
                          Toas.getSnackbarEror(appName,
                              "Erreur de créaction vérifier si la catégorie n'existe pas.");
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
                          ? "Veuillez entrer le nom de la catégorie"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Nom de la catégorie"),
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
                          hintText: "Nom de la catégorie",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
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
                    Text("Image de la catégorie")
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
