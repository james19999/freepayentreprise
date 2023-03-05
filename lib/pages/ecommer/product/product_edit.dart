import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/category_controller.dart';
import 'package:freepayagency/pages/controller/product_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/ecommer/categorie/category_list.dart';
import 'package:freepayagency/pages/ecommer/product/product_list.dart';
import 'package:freepayagency/pages/models/ecommer/category.dart';
import 'package:freepayagency/pages/models/ecommer/product.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import 'package:image_picker/image_picker.dart';

class EditProduct extends ConsumerStatefulWidget {
  final Product? product;
  final String name;
  final dynamic idcateg;
  const EditProduct(
      {super.key, required this.name, required this.idcateg, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _controllername = TextEditingController();
  TextEditingController _controllerprice = TextEditingController();
  TextEditingController _controllercategorie = TextEditingController();
  TextEditingController _controllerdescription = TextEditingController();

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
    _controllercategorie.text = widget.name;
    _controllerdescription.text = widget.product!.description;
    _controllerprice.text = widget.product!.price.toString();
    _controllername.text = widget.product!.name;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(ProductProvider);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Modifier  un produit"),
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
                        var check = await controller.EditProduct(
                            _controllername.text,
                            _controllerprice.text,
                            widget.idcateg.toString(),
                            _controllerdescription.text,
                            _image!);

                        if (check == true) {
                          Toas.getSnackbarsucess(
                              appName, "Le produit à été bien créer");
                          controller.getProducts();
                          Get.off(() => ProductList());
                        } else {
                          Toas.getSnackbarEror(appName,
                              "Erreur lors de la créaction du produit.");
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
                      onTap: () {
                        Get.to(() => CategoryList());
                      },
                      keyboardType: TextInputType.number,
                      controller: _controllercategorie,
                      validator: (value) => value!.isEmpty
                          ? "Veuillez Sélectionnez la catégorie du produit"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Catégorie du produit"),
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
                          hintText: "Catégorie du produit",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
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
                          hintText: "Nom du produit",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controllerprice,
                      validator: (value) => value!.isEmpty
                          ? "Veuillez entrer le prix du produit"
                          : null,
                      decoration: InputDecoration(
                          label: Text("le prix du produit"),
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
                          hintText: "Prix du produit",
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    TextFormField(
                      maxLength: 100,
                      minLines: 5,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      controller: _controllerdescription,
                      validator: (value) => value!.isEmpty
                          ? "Une petite description du produit"
                          : null,
                      decoration: InputDecoration(
                          label: Text("Une petite description "),
                          suffixIcon: Icon(Icons.description_outlined),
                          isDense: true,
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
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
                        height: Get.height * 0.14,
                        child: widget.product!.img == null
                            ? TextButton(
                                onPressed: _openImagePicker,
                                child: _buildImage())
                            : TextButton(
                                onPressed: _openImagePicker,
                                child: _image == null
                                    ? Image.network(
                                        "${BaseImage}${widget.product!.img}")
                                    : _buildImage(),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text("Image de la catégorie"),
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
