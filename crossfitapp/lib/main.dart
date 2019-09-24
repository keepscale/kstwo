import 'package:flutter/material.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 15));
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ScrollingDayCalendar(
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          dateStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayDateFormat: "EEEE dd MMMM",
          dateBackgroundColor: Colors.blue,
          forwardIcon: Icons.arrow_right,
          backwardIcon: Icons.arrow_left,
          pageChangeDuration: Duration(
            milliseconds: 200,
          ),
          widgets: widgets,
          widgetKeyFormat: widgetKeyFormat,
          noItemsWidget: Center(
            child: Text("No items have been added for this date"), // add buttons etc here to add new items for date
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
