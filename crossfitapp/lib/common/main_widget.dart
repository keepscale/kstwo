import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class WidgetOption {

  WidgetOption({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.body,
  });

  final Widget icon;
  final String title;
  final Widget body;

}

class MainWidget extends StatefulWidget  {
  MainWidget({
    Key key,
    @required this.widgetOptions
  }) : super(key: key);
  
  final List<WidgetOption> widgetOptions;

  @override
  _MainWidgetState createState() => _MainWidgetState();

}

class _MainWidgetState extends State<MainWidget> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.widget.widgetOptions.elementAt(_selectedIndex).title),
        ),
        body: this.widget.widgetOptions.elementAt(_selectedIndex).body,
        bottomNavigationBar: BottomNavigationBar(
          items: this.widget.widgetOptions.map((w) => BottomNavigationBarItem(
              icon: w.icon,
              title: Text(w.title),
            )).toList(),          
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}