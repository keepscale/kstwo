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
class _MainInherited extends InheritedWidget {
  _MainInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final MainInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MainInherited oldWidget) {
    return true;
  }
}
class MainWidget extends StatefulWidget  {
  MainWidget({
    Key key,
    @required this.widgetOptions
  }) : super(key: key);
  
  final List<WidgetOption> widgetOptions;
  

  @override
  MainInheritedWidgetState createState() => MainInheritedWidgetState();

  static MainInheritedWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_MainInherited) as _MainInherited).data;
  }
}

class MainInheritedWidgetState extends State<MainWidget> {
  
  int _selectedIndex = 0;
  String _title;
  void initState(){
    super.initState();
    _title = widget.widgetOptions.elementAt(_selectedIndex).title;
  }
  
  void setTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _title = widget.widgetOptions.elementAt(_selectedIndex).title;
    });
  }

  @override
  Widget build(BuildContext context){
    
    var opt = this.widget.widgetOptions.elementAt(_selectedIndex);

    return  new Scaffold(
      appBar: new AppBar(
        title: Text(_title),
      ),
      body: new _MainInherited(
        data: this,
        child: opt.body
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: this.widget.widgetOptions.map((w) => BottomNavigationBarItem(
            icon: w.icon,
            title: Text(w.title),
          )).toList(),          
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
