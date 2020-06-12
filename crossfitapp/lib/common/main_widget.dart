import 'package:crossfitapp/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


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

class MainWidget extends StatelessWidget  {
  MainWidget(this.appStore, this.widgetOptions, {
    Key key
  }) : super(key: key);
  
  final List<WidgetOption> widgetOptions;
  final AppStore appStore;

  @override
  Widget build(BuildContext context){
    return Observer(builder: (_){
    
      WidgetOption opt = widgetOptions.elementAt(appStore.selectedIndex);

      return Scaffold(
        appBar: AppBar(
          title: Text(opt.title),
        ),
        body: opt.body,
        bottomNavigationBar: BottomNavigationBar(
          items: widgetOptions.map((w) => BottomNavigationBarItem(
              icon: w.icon,
              title: Text(w.title),
            )).toList(),          
          currentIndex: appStore.selectedIndex,
          onTap: (i){
            appStore.setAppBatTitle(widgetOptions.elementAt(i).title);
            appStore.selected(i);
          },
        ),
      );
    });
  }
}
