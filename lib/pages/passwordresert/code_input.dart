import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/resert_passord_controller.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/passwordresert/password_input.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class CodeInput extends ConsumerWidget {
   CodeInput({super.key});
  GlobalKey<FormState> _forme = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final controller =ref.watch(PasswordProvider);
    return Scaffold(
      bottomSheet: Container(
            height: Get.height * 0.04,
            width: Get.width,
            color: Colors.grey[200],
            child: Text(
              "Copyright @  DIGITAL SERVICES",
              style:
                  StyleText.copyWith(color: AppColors.mainColor, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
       body: Center(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: Column(children: [
           
              logocontainer(),
                        Text(
                          "Entrer le code que vous avez reçu par mail".tr,
                          // style: StyleText,
                   ),
           
                  SizedBox(
                  height: Get.height * 0.022,
                  ),
                Form(
                   key:_forme ,
                  child:
                TextFormField(
                    controller: codeController,
                    validator: (value) => value!.isEmpty
                        ? "Entrer le code que vous avez reçu par mail".tr
                        : null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          ),
                        ),
                        isDense: true,
                        hintText: "Entrer le code que vous avez reçu par mail".tr,
                        prefixIcon: Icon(
                          Icons.key,
                          color: AppColors.mainColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(5))),
                             ), ),
                           SizedBox(
                          height: Get.height * 0.033,
                            ),
                                   Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: Get.width,
                                    height: Get.height * 0.06,
                                    child: TextButton.icon(
                                        onPressed: () async {
                                          if (_forme.currentState!.validate()) {
                                            var cheked =
                                                await controller.validatecode(
                                                  codeController.text,
                                                    );
                                            if (cheked == true) {
                                             Get.to(()=>PasswordUpdate());
                                            } else {
                                              Toas.getSnackbarEror(appName,
                                                  "Code invalid".tr);
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.key,
                                          color: Colors.white,
                                        ),
                                        label:
                                             Text(
                                                "Envoyer".tr,
                                                style: StyleText.copyWith(
                                                    color: Colors.white),
                                              )
                                    ),
                                  ),             
             ],),
           ),
         ),
       ),
    );
  }
   Image logocontainer() {
    return Image.asset(
      logo,
      height: Get.height * 0.2,
    );
  }
}