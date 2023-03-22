import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/carte/list_cart.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/carte_controller.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ValidationTransaction extends ConsumerStatefulWidget {
  const ValidationTransaction({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ValidationTransactionState();
}

class _ValidationTransactionState extends ConsumerState<ValidationTransaction> {
  GlobalKey<FormState> _formk = GlobalKey<FormState>();
  TextEditingController _controllercode = TextEditingController();
  String? _scanBarcode;
   bool isloade=false;
   
  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _controllercode.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(CartProviders);
    return Scaffold(
      drawer: DrawCostum(),
      appBar: AppBar(
        title: Text("Valider la transaction".tr),
      ),
      bottomSheet: Container(
          height: Get.height * 0.11,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.all(19.0),
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
                        var chek = await controller.Validationtransaction(
                            _controllercode.text);
                        if (chek == true) {
                          Get.to(() => CarteList());
                          Toas.getSnackbarsucess(
                              appName, "La carte à éte bien débiter".tr);
                          controller.getcartcompany();
                        }else{
                          isloade=false;
                        }
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label:
                      isloade==false?
                     Text(
                      "Valider".tr,
                      style: StyleText.copyWith(color: Colors.white),
                    ):CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,))),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Form(
                  key: _formk,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _controllercode,
                        validator: (value) => value!.isEmpty
                            ? "Veuillez entrer le code de la transaction".tr
                            : null,
                        decoration: InputDecoration(
                            label:
                                Text("Entrer le numéro  ou scanner le ticket".tr),
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
                            hintText: "Le numéro du ticket".tr,
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      SizedBox(
                        height: Get.height * 0.031,
                      ),
                      InkWell(
                        onTap: () {
                          scanQR();
                        },
                        child: ZoomTapAnimation(
                          child: Container(
                            height: Get.height * 0.24,
                            width: Get.width,
                            child: Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: 150,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.mainColor,
                                  width: 0.6,
                                ),
                                color: Colors.transparent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text("Cliquez ici pour Scanner le ticket.".tr)
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
