
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:keepwod/model/event.dart';
import 'package:keepwod/service/event_service.dart';
import 'package:keepwod/store/booking_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'planning_store.g.dart';


class PlanningPageStore = _PlanningPageStore with _$PlanningPageStore;

abstract class _PlanningPageStore with Store{

  final EventService eventService;
  _PlanningPageStore(this.eventService, this.date);


  ScrollController scrollController = ScrollController(keepScrollOffset: true);

  @observable
  bool isLoading = true;

  @observable
  DateTime date;

  @observable
  ObservableList<Event> events = ObservableList<Event>();

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
    return Future.delayed(Duration(milliseconds: 100)).then((value) => {isLoading=false});
  }

  
  @action
  Future<BookingStore> prepareBooking(Event event) async {
    return await this.eventService.prepareBooking(event).then((booking){
      return BookingStore(this.eventService, event, booking);
    });
  }


}