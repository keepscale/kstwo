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
class MainInheritedWidget extends StatefulWidget  {
  MainInheritedWidget({
    Key key,
    @required this.child
  }) : super(key: key);
  
  final Widget child;

  @override
  MainInheritedWidgetState createState() => MainInheritedWidgetState();

  static MainInheritedWidgetState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_MainInherited) as _MainInherited).data;
  }
}

class MainInheritedWidgetState extends State<MainInheritedWidget> {
  String _title;
  
  void setTitle(String title) {
    setState(() {
      _title = title;
    });
  }
 @override
  Widget build(BuildContext context){
    return new _MainInherited(
      data: this,
      child: widget.child,
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({
    Key key,
    @required this.widgetOptions
  }) : super(key: key);
  
  final List<WidgetOption> widgetOptions;

  @override
  _MainWidgetState createState() => new _MainWidgetState();
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

    var opt = this.widget.widgetOptions.elementAt(_selectedIndex);

    return new MainInheritedWidget(
      child: new Scaffold(
        appBar: new AppBar(
          title: _AppBarTitle(opt.title),
        ),
        body: opt.body,
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

class _AppBarTitle extends StatelessWidget{
  _AppBarTitle(this.title);

  String title;

  @override
  Widget build(BuildContext context) {

     MainInheritedWidgetState state = MainInheritedWidget.of(context);
     
    return Text(state._title == null ? title : state._title);
  }
  
}