
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/planning/page_prepare_booking.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/store/booking_store.dart';
import 'package:crossfitapp/store/planning_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PlanningPage extends StatefulWidget {
  PlanningPage(this.appStore, {Key key}) : super(key: key);

  final AppStore appStore;


  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  PageController _pageController;
  PlanningPageStore _planningPageStore;

  final DateFormat dayFormat = DateFormat("EEEEE dd MMMM", "fr_FR");
  final DateFormat hourFormat = DateFormat("HH:mm");

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  PageStorageKey _pageStoreKey = PageStorageKey("planning");


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index, BuildContext context){

  }

    @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: PageView.builder(
        controller: _pageController,
        
        onPageChanged: (index) => _onPageChanged(index, context),
        itemCount: 14,      
        itemBuilder: (context, index){
          return Consumer<EventService>(
            builder: (context, eventService, _){
              return Provider(
                create: (_){
                  _planningPageStore = PlanningPageStore(eventService, DateTime.now().add(Duration(days: index)));
                  _refreshIndicatorKey.currentState.show();
                  return _planningPageStore;
                },
                child: Consumer<PlanningPageStore>(
                  builder: (context, planningPageStore, _){

                    return RefreshIndicator(
                          onRefresh: ()=>planningPageStore.load(),
                          child: CustomScrollView(
                            key: _pageStoreKey,
                            controller: planningPageStore.scrollController,
                            slivers: <Widget>[
                              ///First sliver is the App Bar
                              SliverAppBar(
                                ///Properties of app bar
                                backgroundColor: Colors.white,
                                floating: false,
                                pinned: true,
                                expandedHeight: 80.0,                                
                                flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: true,                                  
                                  title: Text(
                                    dayFormat.format(DateTime.now().add(Duration(days: index))),
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,),
                                  ),
                                  background: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.black26,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Observer(builder: (_){
                                
                                if (planningPageStore.hours.length == 0 && !planningPageStore.isLoading ){
                                  return SliverList(delegate: SliverChildListDelegate([
                                    Center(child: Text("Aucun créneau disponible"))
                                  ]));
                                }

                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {

                                      DateTime hour = planningPageStore.hours[index];
                                      List<Event> events = planningPageStore.eventsByHours[hour];
                                      events.sort((a,b) => a.title.compareTo(b.title));

                                      return Container(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              RotatedBox(quarterTurns: 3, child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child:  Text(hourFormat.format(hour)),
                                              )),
                                              Expanded(
                                                
                                                child: Row(
                                                  children:  events.map((e) => EventWidget(event: e)).toList(),),)
                                            ],)
                                          
                                      );
                                    },
                                    childCount: planningPageStore.hours.length,
                                    /// Set childCount to limit no.of items
                                    /// childCount: 100,
                                  ),
                                );
                              })
                              
                            ],
                          ),
                        );
                      }
                    )
                );
            }
          );
        }
      ),
      onRefresh: ()=>_planningPageStore.load(),
    );
  }
}

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key key,
    @required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    PlanningPageStore store = Provider.of(context);
    int rest = event.maxAttendees - event.totalAttendees;
    return Expanded(
      child: InkWell(
        child: Card(
          elevation: 1.0,
          color: event.type == EventType.BOOKED ? Colors.lightGreen[200] : Colors.white,
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 0),
              title: Text(
                event.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(rest <= 0 ? "Complet" : "$rest places", style: TextStyle(color: event.color)),
              trailing: event.type == EventType.BOOKED ? 
                  Icon(Icons.check_circle_outline, size: 20.0) :
                event.hasSubscribeNotif ? 
                  Icon(Icons.notifications, size: 20.0) :
                  Icon(Icons.keyboard_arrow_right, size: 20.0)
            ),
          ),
        ),                
        onTap: () async{             
          BookingStore booking = await store.prepareBooking(event);      
          
          var r = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrepareBookingPage(booking: booking))
          );
          store.load();
        }
      ),
    );
  }
}