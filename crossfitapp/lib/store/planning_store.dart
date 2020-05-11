
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:crossfitapp/store/booking_store.dart';
import 'package:mobx/mobx.dart';

part 'planning_store.g.dart';


class PlanningPageStore = _PlanningPageStore with _$PlanningPageStore;

abstract class _PlanningPageStore with Store{

  final EventService eventService;
  _PlanningPageStore(this.eventService, this.date);

  @observable
  bool isLoading;

  @observable
  DateTime date;

  @observable
  ObservableList<Event> events = ObservableList<Event>();

  @observable
  BookingStore preparedBooking;

  @computed
  List<DateTime> get hours{
    return eventsByHours.keys.toList();
  }
  @computed
  Map<DateTime, List<Event>> get eventsByHours{
    Map<DateTime, List<Event>> eventsByHours = SplayTreeMap();
    eventsByHours.addAll(groupBy(events.where((e)=>e.startAt.isAfter(DateTime.now())), (e)=>e.startAt));
    return eventsByHours;
  }
  
  @action
  Future<void> load() async {
    isLoading = true;
    events.clear();
    events.addAll(await this.eventService.getEvents(date));
    isLoading = false;
    
  }

  
  @action
  Future<Booking> prepareBooking(Event event) async {
    Booking b = await this.eventService.prepareBooking(event).then((booking){
      booking.event = event;
      return booking;
    });
    this.preparedBooking = BookingStore(this.eventService, b.id, b.event, b.date, b.timeslotId, b.subscriptionId, b.createdAt, b.error);
    return b;
  }


}