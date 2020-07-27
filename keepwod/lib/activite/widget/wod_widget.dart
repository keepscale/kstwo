import 'package:keepwod/model/booking.dart';
import 'package:keepwod/model/wod.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class WodDetailWidget extends StatelessWidget {
  
  WodDetailWidget(this.wod, {Key key,}) :
    result = wod.myresultAtDate, super(key: key);

  final Wod wod;
  final WodResult result;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(child: Text("${this.wod.description.trim().replaceAll("\n\n\n", "\n\n")}"), padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),),
              ],
            ),
          ),
          Container(height:40, child: VerticalDivider( color: Colors.black)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(child: Text("Pas de score disponible"),                               visible: result == null,),
                Visibility(child: I18nText("wod.score."+EnumToString.parse(this.wod.score)),     visible: result != null,),
                ScoreWidget({"min": result?.totalMinute, "sec": result?.totalSecond},            visible: result != null && this.wod.score == Score.FOR_TIME,),
                ScoreWidget({"tour(s)": result?.totalCompleteRound, "rép.": result?.totalReps},  visible: result != null && this.wod.score == Score.FOR_ROUNDS_REPS),
                ScoreWidget({"à":FlutterI18n.translate(context, "wod.category."+EnumToString.parse(result?.category??Category.RX)),"Kg": result?.totalLoadInKilo},                                     visible: result != null && result.totalLoadInKilo != null,),
              ],
            ),
          )
        ]
      ),
    );
  }
}



class ScoreWidget extends StatelessWidget {
  const ScoreWidget(this.map, {this.visible,  key}) : super(key: key);

  final Map map;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: this.visible??true,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: this.map.entries.map((e) => Text("${e.value} ${e.key} ")).toList()
        ),
      ),
    );
  }
}