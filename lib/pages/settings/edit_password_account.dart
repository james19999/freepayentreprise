import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/user_controller.dart';
import 'package:freepayagency/pages/login/login.dart';
import 'package:freepayagency/pages/services/user_service.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EditPasswordAccount extends ConsumerWidget {
  EditPasswordAccount({super.key});
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _newpassword = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(AuthProviders);
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
                        if (_formkey.currentState!.validate()) {
                          var chek =
                              await UserService.newPassword(_newpassword.text);
                          if (chek == true) {
                            Get.offAll(() => Login());
                            Toas.getSnackbarsucess(
                                appName, "Le mot de passe à été bien modifier".tr);
                          } else {
                            Toas.getSnackbarEror(appName,
                                "Erreur de modification du mot de passe".tr);
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
          title: Text("Modifier le mot de passe".tr, style: StyleText),
          elevation: 0,
          backgroundColor: AppColors.mainColor,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                // TextFormField(
                                //   validator: (value) =>
                                //       value!.isEmpty ? "Ancien mot de passe" : null,
                                //   decoration: InputDecoration(
                                //       label: Text("Ancien mot de passe".tr),
                                //       isDense: true,
                                //       filled: true,
                                //       enabledBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.circular(5.0),
                                //           borderSide: BorderSide(
                                //             color: AppColors.mainColor,
                                //             width: 1.0,
                                //           )),
                                //       focusedBorder: OutlineInputBorder(
                                //         borderSide:
                                //             BorderSide(color: AppColors.mainColor),
                                //         borderRadius: BorderRadius.circular(5.0),
                                //       ),
                                //       border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5.0))),
                                // ),
                                // SizedBox(
                                //   height: Get.height * 0.04,
                                // ),
                                TextFormField(
                                  controller: _newpassword,
                                  validator: (value) => value!.isEmpty
                                      ? "Entrer le nouveau mot de passe".tr
                                      : null,
                                  decoration: InputDecoration(
                                      label: Text("Nouveau mot de passe".tr),
                                      isDense: true,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: BorderSide(
                                            color: AppColors.mainColor,
                                            width: 1.0,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.mainColor),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
