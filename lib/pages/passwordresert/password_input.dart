import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/loaderpassword.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/resert_passord_controller.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/login/login.dart';
import 'package:freepayagency/pages/passwordresert/code_input.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:freepayagency/splash_home.dart';
import 'package:get/get.dart';

class PasswordUpdate extends ConsumerWidget {
   PasswordUpdate({super.key});
  GlobalKey<FormState> _forme = GlobalKey<FormState>();
   final  obscur = StateProvider((ref) => true);
   final  _obscur = StateProvider((ref) => true);
    final isloade =StateProvider((ref) => false);
 
  
  TextEditingController passwordController = TextEditingController();
  TextEditingController passconfirmController = TextEditingController();


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
                          "Modifié votre mot de passe".tr,
                          // style: StyleText,
                   ),
           
                  SizedBox(
                  height: Get.height * 0.022,
                  ),
                Form(
                   key:_forme ,
                  child:Column(children: [
                        TextFormField(
                                  controller: passwordController,
                                  validator: (value) => value!.isEmpty
                                      ? "Votre nouveau mot de passe".tr
                                      : null,
                                  obscureText: ref.watch(obscur),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      hintText: "Nouveau mot de passe".tr,
                                      isDense: true,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.mainColor,
                                        size: 25,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                              ref.watch(obscur.notifier).state=!ref.watch(obscur);
                                            // setState(() {
                                            //   obscur = !obscur;
                                            // });
                                          },
                                          icon: Icon(
                                              color: AppColors.mainColor,
                                              ref.watch(obscur)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),




                                TextFormField(
                                  controller: passconfirmController,
                                  validator: (value) => value!.isEmpty
                                      ? "Confirmez votre mot de passe".tr
                                      : null,
                                  obscureText: ref.watch(_obscur),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      hintText: "Confirmez votre mot de passe".tr,
                                      isDense: true,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.mainColor,
                                        size: 25,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                             ref.watch(_obscur.notifier).state=!ref.watch(_obscur);
                                            // setState(() {
                                            //   obscur = !obscur;
                                            // });
                                          },
                                          icon: Icon(
                                              color: AppColors.mainColor,
                                              ref.watch(_obscur)
                                                  ? Icons.visibility
                                                  : Icons.visibility_off)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                               ],)
                            ),
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
                                                   ref.watch(isloade.notifier).state=true;
                                               if(passwordController.text ==passconfirmController.text){
                                                var cheked =
                                                    await controller.updatepassword(
                                                        passwordController.text);
                                                if (cheked == true) {
                                                  Get.offAll(() => LoaderPassword(),
                                                      transition: Transition.fade);
                                                } else {
                                                  Toas.getSnackbarEror(appName,
                                                      "Erreur de modification du mot de passe".tr);
                                                   ref.watch(isloade.notifier).state=false;   
                                                }
                                               }else{
                                                    Toas.getSnackbarEror(appName,
                                                      "Les mot de passe doivent être identique".tr);
                                                   ref.watch(isloade.notifier).state=false;   

                                               }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                        ),
                                        label:
                                            ref.watch(isloade)==false?
                                             Text(
                                                "Envoyer".tr,
                                                style: StyleText.copyWith(
                                                    color: Colors.white),
                                              ):CircularProgressIndicator(color: Colors.white,strokeWidth: 1.5,)
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