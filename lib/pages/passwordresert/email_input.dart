import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/resert_passord_controller.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/passwordresert/code_input.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';

class Emailinput extends ConsumerWidget {
   Emailinput({super.key});
  GlobalKey<FormState> _forme = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


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
                          "Entrer l' adresse mail du compte",
                          // style: StyleText,
                   ),
           
                  SizedBox(
                  height: Get.height * 0.022,
                  ),
                Form(
                   key:_forme ,
                  child:
                TextFormField(
                    controller: emailController,
                    validator: (value) => value!.isEmpty
                        ? "Entrer votre adresse mail"
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
                        hintText: "Votre adresse mail",
                        prefixIcon: Icon(
                          Icons.mail,
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
                                                await controller.sendmail(
                                                    emailController.text,
                                                    );
                                            if (cheked == true) {
                                              Get.to(()=>CodeInput());
                                            } else {
                                              Toas.getSnackbarEror(appName,
                                                  "Erreur l'adresse mail n'existe pas.");
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.mail,
                                          color: Colors.white,
                                        ),
                                        label:
                                             Text(
                                                "Envoyer",
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