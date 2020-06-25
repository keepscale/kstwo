import 'dart:developer';

import 'package:crossfitapp/activite/detail_result_page.dart';
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/store/activite_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class DetailBookingPage extends StatefulWidget {
  

  DetailBookingPage({Key key, this.store}) : super(key: key);

  final ActivitePageStore store;

  @override
  _DetailBookingPageState createState() => _DetailBookingPageState();
}

class _DetailBookingPageState extends State<DetailBookingPage> with SingleTickerProviderStateMixin{
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy 'à' HH:mm", "fr");

  TabController tabController;

  @override
  void initState() { 
    super.initState();
    tabController = TabController(length: widget.store.booking.value.wods.length, vsync: this);
    widget.store.selectWod(0);
    tabController.addListener(() {
      widget.store.selectWod(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        Booking booking = widget.store.booking.value;
        return SafeArea(
          child: DefaultTabController(
            length: booking.wods.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Mon résultat"),
                bottom: booking.wods.length > 1 ? TabBar(
                  controller: tabController,
                    tabs: booking.wods.map((e) => Tab(child: Text(e.name))).toList(),
                ) : null,
              ),
              body: TabBarView(
                controller: tabController,
                children: booking.wods.map((Wod wod) {
                  return ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text(dateFormat.format(booking.startAt)),
                          subtitle: Text(
                            wod.description,
                          )
                        ),

                        Divider(),

                        ListTile(
                          title: Text(wod.score.toString()),
                          subtitle: MyResult(result: wod.myresultAtDate, store: widget.store)
                        ),

                        Divider(),

                        ListTile(
                          title: Text("Classement"),
                          subtitle: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'N°',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nom',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Resultat',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: widget.store.rankings.map((element) =>  
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text("1")),
                                    DataCell(Text(element.displayName)),
                                    DataCell(Text(element.displayResult)),
                                  ],
                                )
                              ).toList()
                          ),
                        )
                      ],
                  );
                }).toList()
              ),
              floatingActionButton: FloatingActionButton(child: Icon(Icons.edit), onPressed: (){

                this.widget.store.editWodResult();

                return Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailResultPage(store: this.widget.store))
                );

              },),
            ),
          ),
        );
      }
    );
  }
}

class MyResult extends StatelessWidget {
  const MyResult({Key key, this.result, this.store}) : super(key: key);

  final ActivitePageStore store;
  final WodResult result;

  @override
  Widget build(BuildContext context) {
    if (result==null){
      return Text("Pas de résultat enregistré");  
    }
    else{

      return Row(children:[ 
          Text(result.category.toString() + " | "),
          TextResult(result.totalMinute, "min"),
          TextResult(result.totalSecond, "s"),
          TextResult(result.totalLoadInKilo, "Kg"),
          TextResult(result.totalCompleteRound, "tour"),
          TextResult(result.totalReps, "répétions"),]
        );  
    }
  }
}

class TextResult extends StatelessWidget {
  const TextResult(this.value, this.unit, {Key key}) : super(key: key);
  final dynamic value;
  final String unit;
  
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null,
      child: Text("$value $unit "),
    );
  }
}