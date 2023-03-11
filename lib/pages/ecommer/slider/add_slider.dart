import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/slider_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/ecommer/slider/slider_list.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class AddSlider extends ConsumerStatefulWidget {
  const AddSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSliderState();
}

class _AddSliderState extends ConsumerState<AddSlider> {
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
    final controller = ref.watch(SliderProvider);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Ajouter un slider"),
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
                        var check = await controller.AddSlider(
                            _controllername.text, _image!);
                        if (check == true) {
                          Toas.getSnackbarsucess(appName, "Slider créer");
                          controller.getSliders();
                          Get.off(() => SlideList());
                        } else {
                          Toas.getSnackbarEror(
                              appName, "Erreur de créaction du Slider .");
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
                      validator: (value) =>
                          value!.isEmpty ? "Veuillez entrer le titre" : null,
                      decoration: InputDecoration(
                          label: Text("Titre"),
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
                          hintText: "Titre",
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
                    Text("Image du slider")
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
