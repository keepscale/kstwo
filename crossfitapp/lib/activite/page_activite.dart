
import 'package:crossfitapp/activite/detail_booking_page.dart';
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/planning/page_prepare_booking.dart';
import 'package:crossfitapp/service/booking_service.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/activite_store.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/store/booking_store.dart';
import 'package:crossfitapp/store/planning_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
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
                          
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Observer(
                                    builder: (_) {
                                      Booking booking = activitePageStore.pastBookings[index];
                                      return Card(
                                          child: ListTile(
                                              title: Text(
                                                booking.title,
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              subtitle: Text(dateFormat.format(booking.startAt)),
                                              leading: Icon(Icons.check_circle),
                                              onTap:  () async{             
                                                await activitePageStore.loadDetail(booking);
                                                if (activitePageStore.booking.value.wods.length > 0){
                                                  return Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => DetailBookingPage(store: activitePageStore))
                                                  );
                                                }
                                                else{

                                                }
                                              },
                                            ),
                                      );
                                    }
                                  );
                                },
                                childCount: activitePageStore.pastBookings.length,
                            ),
                          )
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
}