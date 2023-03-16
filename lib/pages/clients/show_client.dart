import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freepayagency/pages/clients/edit_client.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/drawer/drawercostem.dart';
import 'package:freepayagency/pages/models/client_model.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:freepayagency/pages/toas/toas.dart';
import 'package:get/get.dart';

class ShowClient extends ConsumerStatefulWidget {
  final ClientModel client;
  const ShowClient({super.key, required this.client});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowClientState();
}

class _ShowClientState extends ConsumerState<ShowClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: DrawCostum(),
        appBar: AppBar(
          title: Text(
            'Informations client',
            style: StyleText,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditClient(clientmodel: widget.client),
                      transition: Transition.fade);
                },
                icon: Icon(
                  Icons.edit,
                  size: iconsizes,
                )),
            IconButton(
                onPressed: () {
                  Toas.message(context, "Action indisponible");
                },
                icon: Icon(
                  Icons.delete,
                  size: iconsizes,
                  color: Colors.red,
                )),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          '${widget.client.name}'.substring(0, 1),
                          style: StyleText.copyWith(color: Colors.black),
                        ),
                      )),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text(
                        "Info personnelle",
                        style: StyleText.copyWith(fontSize: fontsizes),
                      ),
                    ],
                  ),
                  Listilinfo("Nom", "${widget.client.name}".toUpperCase()),
                  Listilinfo(
                      "Téléphone", "${widget.client.phone}".toUpperCase()),
                  Listilinfo("Ville", "${widget.client.ville}".toUpperCase()),
                  Listilinfo(
                      "Adresse", "${widget.client.adress}".toUpperCase()),
                  Listilinfo("Email", "${widget.client.email}"),
                  Listilinfo("Quartier", "${widget.client.quartier}"),
                  Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Wrap(children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                      width: Get.width *0.3,
                      child: TextFormField(
                      
                        decoration: InputDecoration(
                          hintText: "Modifier l'identifiant",
                          contentPadding: EdgeInsetsGeometry.lerp(
                      EdgeInsets.all(5.0), EdgeInsets.all(8.0), 1),
                          isDense: true,
                          border: OutlineInputBorder()
                        ),
                      )) ,
                    Container(
                      width: Get.width *0.3,

                      child: TextButton(onPressed: () {
                        
                      }, child: Text("Modifier ")),
                    )
                     ],)
                   
                  ],)
                ],
              ),
            )));
  }

  ListTile Listilinfo(title, subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
