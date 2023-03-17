import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:freepayagency/pages/controller/history_controller.dart';
import 'package:freepayagency/pages/helper/date_convert.dart';
import 'package:freepayagency/pages/styles/style.dart';
import 'package:get/get.dart';

class HistoryTransfert extends ConsumerStatefulWidget {
  const HistoryTransfert({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryTransfertState();
}

class _HistoryTransfertState extends ConsumerState<HistoryTransfert> {
  @override
  Widget build(BuildContext context) {
    final controller =ref.watch(HistoryProviders);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom:  TabBar(
            indicatorColor: AppColors.mainColor,
            tabs: [
              Tab(
                child: Text(
                  "Jour".tr,
                  style: StyleText,
                ),
              ),
              Tab(
                child: Text(
                  "Semaine".tr,
                  style: StyleText,
                ),
              ),
              Tab(
                child: Text(
                  "Mois".tr,
                  style: StyleText,
                ),
              ),
            ],
          ),
          title: Text('Historiques des transactions'.tr),
        ),
        body: TabBarView(
          children: [
            Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.Historyday.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0), child: 
                        ListTile(title:
                       Text("${controller.Historyday[index].amount} XOF"),
                       subtitle: Text("${controller.Historyday[index].cartNumber}"),
                       trailing: Text(DateConverter.formatDate(controller.Historyday[index].createdAt)),
                       
                       )
                      ),
                ),
              ),
            ]),
            Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.Historyweek.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0), child:  ListTile(title:
                       Text("${controller.Historyweek[index].amount} XOF"),
                       subtitle: Text("${controller.Historyweek[index].cartNumber}"),
                       trailing: Text(DateConverter.formatDate(controller.Historyweek[index].createdAt)),
                       
                       )),
                ),
              ),
            ]),
            Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.HistoryMounth.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0), child:  ListTile(title:
                       Text("${controller.HistoryMounth[index].amount} XOF"),
                       subtitle: Text("${controller.HistoryMounth[index].cartNumber}"),
                       trailing: Text(DateConverter.formatDate(controller.HistoryMounth[index].createdAt)),
                       
                       )),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
