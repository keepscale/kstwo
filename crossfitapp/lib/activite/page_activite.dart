
import 'package:crossfitapp/activite/detail_booking_page.dart';
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/planning/page_prepare_booking.dart';
import 'package:crossfitapp/service/booking_service.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/activite_store.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/store/result_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivitePage extends StatelessWidget {

  final DateFormat dateFormat = DateFormat("dd MMMM yyyy 'à' HH:mm", "fr");

  ScrollController _scrollController = ScrollController(keepScrollOffset: true);


  ActivitePage({Key key}) : super(key: key);

  bool _onNotification(Notification notification, ActivitePageStore store) {
      
      if (notification is ScrollUpdateNotification) {
        if (_scrollController.position.maxScrollExtent >
                _scrollController.offset &&
            _scrollController.position.maxScrollExtent -
                    _scrollController.offset <= 100) {
                  
          if (!store.isLoading) {
            store.loadMore();
          }
        }
      }

      return true;
    }

  @override
  Widget build(BuildContext context) {
    return Consumer3<BookingService, WodResultService, AppStore>(
      builder: (context, bookingService, wodResultService, appStore, _){
        
        return Provider(
          create: (_){
            var activitePageStore = ActivitePageStore(bookingService, wodResultService, appStore);
            activitePageStore.load();
            return activitePageStore;
          },
          child: Consumer<ActivitePageStore>(
            builder: (context, activitePageStore, _){

              return NotificationListener(
                onNotification: (notif)=>_onNotification(notif, activitePageStore),
                child: RefreshIndicator(
                  onRefresh: () => activitePageStore.load(),
                  child: Observer(
                    builder: (_) {
                      return CustomScrollView(
                        controller: _scrollController,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  Booking booking = activitePageStore.incommingBookings[index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        booking.title,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(dateFormat.format(booking.startAt)),
                                      leading: Icon(Icons.access_time)
                                    ),
                                  );
                                },
                                childCount: activitePageStore.incommingBookings.length,
                            ),
                          ),
                          buildPastBooking(activitePageStore)
                        ]
                      );
                    }
                  )
                ),
              );
            }
          )
        );
      }
    );
  }

  SliverList buildPastBooking(ActivitePageStore activitePageStore) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
              Booking booking = activitePageStore.pastBookings[index];
              return Card(
                  child: InkWell(
                    onTap:  () async{             
                      ResultStore store = await activitePageStore.editWodResult(index);
                      /*return Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailBookingPage(store: store))
                      );*/
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            booking.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(dateFormat.format(booking.startAt)),
                          leading: Icon(Icons.check_circle)
                        ),
                        WodsWidget(booking.wods)
                      ],
                    )
                  )
              );
          },
          childCount: activitePageStore.pastBookings.length,
      ),
    );
  }
}
class WodsWidget extends StatelessWidget {
  const WodsWidget(this.wods, {
    Key key,
  }) : super(key: key);

  final List<Wod> wods;

  @override
  Widget build(BuildContext context) {
    if ( (wods?.length??0) > 0 ){
      return WodsTabWidget(wods);
    }
    else{
      return ListTile(
        title: Text("Pas de wod disponible"),
      );
    }
  }
}

class WodsTabWidget extends StatefulWidget {
  const WodsTabWidget(this.wods, {
    Key key,
  }) : super(key: key);

  final List<Wod> wods;

  @override
  _WodsTabWidgetState createState() => _WodsTabWidgetState();
}

class _WodsTabWidgetState extends State<WodsTabWidget> with SingleTickerProviderStateMixin {
  
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: this.widget.wods?.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }
  
  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _tabController.length > 1,
          child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              tabs: widget.wods.map((e) => Tab(text:e.name)).toList()
          ),
        ),
        WodWidget(widget.wods[_tabController.index])
      ],
    );
  }
}

class WodWidget extends StatelessWidget {
  const WodWidget(this.wod, {
    Key key,
  }) : super(key: key);

  final Wod wod;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(this.wod.description),
        subtitle: Text("${this.wod.myresultAtDate?.totalCompleteRound} Rounds et ${this.wod.myresultAtDate?.totalReps} reps"),
      );
  }
}