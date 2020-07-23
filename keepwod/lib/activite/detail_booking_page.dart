import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:keepwod/activite/detail_result_page.dart';
import 'package:keepwod/activite/widget/wod_widget.dart';
import 'package:keepwod/model/wod.dart';
import 'package:keepwod/store/result_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class DetailBookingPage extends StatelessWidget {
  
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy 'à' HH:mm", "fr");

  DetailBookingPage(this.store, {Key key}) : super(key: key);

  final ResultStore store;

  @override
  Widget build(BuildContext context) {
    Set<String> columns = {"N°", "Catégorie", "Nom", "Charge"};
    if (store.wod.score != Score.FOR_LOAD){
      columns.add("Résultat");
    }
    return Observer(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Mon résultat"),
            ),
            body: ListView(
              children: <Widget>[
                
                WodDetailWidget(store.wod),

                Divider(color: Colors.black, height: 2,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Classement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                
                DataTable(
                  columnSpacing: 1,

                  columns: columns.map((column) => 
                    DataColumn(
                        label: Text(column),
                    )
                  ).toList(),
                  rows: store.rankings.asMap().entries.map((entry){
                        DataRow row = DataRow(
                          cells: <DataCell>[
                            DataCell(Text("${entry.key+1}")),
                            DataCell(I18nText("wod.category."+EnumToString.parse(entry.value.category))),
                            DataCell(Text(entry.value.displayName)),
                            DataCell(Text("${entry.value.loadInKilo}"))
                          ]
                        );
                        if (store.wod.score != Score.FOR_LOAD){
                          row.cells.add(DataCell(Text("${entry.value.displayResult}")));
                        }
                        return row;
                      }
                    ).toList()
                ),
              ],
          ),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.edit), onPressed: (){
              this.store.edit();
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailResultPage(store: this.store))
              );

            }
          ),
          ),
        );
      }
    );
  }
}
