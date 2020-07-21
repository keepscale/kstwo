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
                    rows: store.rankings.map((element) =>  
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
