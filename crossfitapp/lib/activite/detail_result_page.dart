import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/store/result_store.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class DetailResultPage extends StatefulWidget {

  final ResultStore store;

  DetailResultPage({Key key, this.store}) : super(key: key);

  @override
  _DetailResultPageState createState() => _DetailResultPageState();
}

class _DetailResultPageState extends State<DetailResultPage> {

  final DateFormat dateFormat = DateFormat("dd MMMM yyyy 'à' HH:mm", "fr");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: Text("Modifier mon résultat"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text("Enregistrer", style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        this.widget.store.save().then((value) =>  Navigator.pop(context));
                       
                      }
                    }
                  )
                ],
              ),
              body: Card(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      
                      buildListTile(
                        visible: widget.store.wod.score == Score.FOR_TIME,
                        children: [
                          NumberFormField(value: widget.store.totalMinute, label: "Minutes", doubleValue: false,
                          onChanged: (value) => this.widget.store.totalMinute = value,),
                          NumberFormField(value: widget.store.totalSecond, label: "Secondes", max: 59, doubleValue: false,
                          onChanged: (value) => this.widget.store.totalSecond = value,),
                      ]),
                      buildListTile(
                        visible: widget.store.wod.score == Score.FOR_ROUNDS_REPS,
                        children: [
                          NumberFormField(value: widget.store.totalCompleteRound, label: "Rounds", doubleValue: false,
                          onChanged: (value) => this.widget.store.totalCompleteRound = value,),
                          NumberFormField(value: widget.store.totalReps, label: "Répétion", doubleValue: false,
                          onChanged: (value) => this.widget.store.totalReps = value,),
                      ]),
                      buildListTile(
                        visible: true,
                        children: [
                          NumberFormField(value: widget.store.totalLoadInKilo, label: "Charge en Kg", doubleValue: true,
                          onChanged: (value) => this.widget.store.totalLoadInKilo = value,),
                      ]),
                      
                      ListChoiceChip(label: "Classement", 
                        selected: this.widget.store.category, 
                        i18n: "wod.category.",
                        values: Category.values, 
                        onChanged: (selected) => this.widget.store.category=selected,),

                      ListChoiceChip(label: "Division", 
                        selected: this.widget.store.division, 
                        i18n: "wod.division.",
                        values: Division.values, 
                        onChanged: (selected) => this.widget.store.division=selected,),
                        
                      ListTile(
                        title: TextFormField(
                          initialValue: this.widget.store.comments,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Note personnelle",
                          ),
                          maxLines: 2,
                          maxLength: 512,
                          onChanged: (s)=>this.widget.store.comments = s,
                        ),
                      )
                    ],
                  ),
                ),
              )
          )
        );
      }
    );
  }

  Widget buildListTile({bool visible, List<Widget> children}) {
    return Visibility(
        visible: visible,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map((e) => Expanded(child: e,)).toList()
          ),
      ),
    );
  }
}

class ListChoiceChip<T> extends StatelessWidget {
  ListChoiceChip({Key key, this.label, this.selected, this.i18n, this.values, this.onChanged}) : super(key: key);

  String label;
  T selected;
  String i18n;
  List<T> values;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListTile(
        title: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(label, style: TextStyle(fontSize: 14),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: values.map((e) => ChoiceChip(
                label: I18nText((this.i18n??"")+EnumToString.parse(e)), 
                selected: this.selected == e,
                onSelected: (bool selected) => selected ? onChanged(e) : '', )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberFormField extends StatelessWidget {
  const NumberFormField({
    Key key,
    @required this.value,
    @required this.label,
    this.max,
    @required this.doubleValue,
    this.onChanged
  }) : super(key: key);

  final bool doubleValue;
  final dynamic value;
  final String label;
  final double max;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      initialValue: value?.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        dynamic val = doubleValue ? double.tryParse(value) : int.tryParse(value);
        if (val == null || val<0 || (max!=null && val>max)) {
          return 'Saisissez un nombre valide';
        }
        return null;
      },
      onChanged: (value){
        onChanged(doubleValue ? double.tryParse(value) : int.tryParse(value));
      },
    );
  }
}
