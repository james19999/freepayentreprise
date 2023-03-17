import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/user_controller.dart';
import 'package:freepayagency/pages/helper/images.dart';
import 'package:freepayagency/pages/home/home.dart';
import 'package:freepayagency/pages/passwordresert/email_input.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:freepayagency/pages/urls/baseurl.dart';
import 'package:freepayagency/splash_home.dart';
import 'package:get/get.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool obscur = true;
  bool isloade = false;
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _forme = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(AuthProviders);
    return WillPopScope(
        child: Scaffold(
          // appBar: AppBar(),
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
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logocontainer(),
                      Text(
                        "Connectez vous à votre entreprise".tr,
                        // style: StyleText,
                      ),
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      Form(
                          key: _forme,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) => value!.isEmpty
                                      ? "Entrer votre adresse mail".tr
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
                                      hintText: "Votre adresse mail".tr,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: AppColors.mainColor,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) => value!.isEmpty
                                      ? "Entrer votre mot de passe".tr
                                      : null,
                                  obscureText: obscur,
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
                                      hintText: "Votre mote de passe".tr,
                                      isDense: true,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.mainColor,
                                        size: 25,
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscur = !obscur;
                                            });
                                          },
                                          icon: Icon(
                                              color: AppColors.mainColor,
                                              obscur
                                                  ? Icons.visibility
                                                  : Icons.visibility_off)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Text("Mot de passe "),
                                //   ],
                                // ),
                                SizedBox(
                                  height: Get.height * 0.05,
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
                                              await controller.AuthConstumer(
                                                  emailController.text,
                                                  passwordController.text);
                                          if (cheked == true) {
                                            setState(() {
                                              isloade = true;
                                            });
                                            Get.offAll(() => SplashHome(),
                                                transition: Transition.fade);
                                          } else {
                                            Toas.getSnackbarEror(appName,
                                                "Erreur de connexion vérifier vos informations".tr);
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.lock_open_outlined,
                                        color: Colors.white,
                                      ),
                                      label: isloade == false
                                          ? Text(
                                              "Se Connecter".tr,
                                              style: StyleText.copyWith(
                                                  color: Colors.white),
                                            )
                                          : CircularProgressIndicator.adaptive(
                                              strokeWidth: 2,
                                              backgroundColor: Colors.white,
                                            )),
                                ),

                                SizedBox(
                                  height: Get.height * 0.034,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Get.to(() => Emailinput(), transition: Transition.fade);
                                  },
                                  child: Text("Mot de passe oublié ?".tr),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Voulez vous fermer l'application ?".tr),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Oui'.tr),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('Non'.tr),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        });
  }

  Image logocontainer() {
    return Image.asset(
      logo,
      height: Get.height * 0.2,
    );
  }
}
