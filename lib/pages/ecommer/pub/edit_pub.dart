import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/pub_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/ecommer/pub/pub_list.dart';
import 'package:freepayagency/pages/models/ecommer/pub.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';

class EditPub extends ConsumerStatefulWidget {
  final Pubs pubs;
  const EditPub({super.key, required this.pubs});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPubState();
}

class _EditPubState extends ConsumerState<EditPub> {
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
    final controller = ref.watch(PubProvider);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: DrawCostum(),
        appBar: AppBar(
          title: Text("Ajouter une produit mise en avant"),
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
                        var check =
                            await controller.UpdatePub(_image!, widget.pubs.id);
                        if (check == true) {
                          Toas.getSnackbarsucess(
                              appName, "Produit mise en avant modifié");
                          controller.getPub();
                          Get.off(() => PubList());
                        } else {
                          Toas.getSnackbarEror(
                              appName, "Erreur de modification .");
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
                  child: Column(children: [
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
                  ]))),
        ));
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
