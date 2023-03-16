import 'package:freepayagency/pages/models/history.dart';
import 'package:freepayagency/pages/services/history_service.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HistoryCotroller extends ChangeNotifier {
       List<History> Historyday= [];
       List<History> HistoryMounth= [];
       List<History> Historyweek= [];
       List<History> Historyall= [];
        int todayTotal =0;
        int mounthTotal =0;
        int weekTotal =0;
        int globalTotal =0;
        HistoryCotroller() {
          getallhistoryMethode();
          
        }
    
        getallhistoryMethode () async {
          
             HistoryMounth= await HistoryService.gethistoryoffmonth();
             mounthTotal = HistoryMounth
            .map((item) => int.parse(item.amount))
            .reduce((value, current) => value + current);
             Historyweek= await HistoryService.gethistoryoffweek();
            Historyall= await HistoryService.getallhistory();
              weekTotal = Historyweek
            .map((item) => int.parse(item.amount))
            .reduce((value, current) => value + current);

             globalTotal = Historyall
            .map((item) => int.parse(item.amount))
            .reduce((value, current) => value + current);
            try {
            Historyday= await HistoryService.gethsitoryoffcompanytoday();

             todayTotal = Historyday
            .map((item) => int.parse(item.amount))
            .reduce((value, current) => value + current);

            } catch (e) {
            }
            notifyListeners();

        }
      
}

final HistoryProviders = ChangeNotifierProvider<HistoryCotroller>(
  (ref) {
    return HistoryCotroller();
  },
);
