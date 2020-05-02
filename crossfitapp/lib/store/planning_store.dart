
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:mobx/mobx.dart';

part 'planning_store.g.dart';

class PlanningStore = _PlanningStore with _$PlanningStore;

abstract class _PlanningStore with Store{


  final EventService eventService;
  _PlanningStore(this.eventService, this.startDate);

  @observable
  DateTime startDate;

  @observable
  DateTime currenDate;

  @observable
  ObservableList<Event> events = ObservableList<Event>();
  
  @computed
  Map<DateTime, List<Event>> get eventsByHours{
    Map<DateTime, List<Event>> eventsByHours = SplayTreeMap();
    eventsByHours.addAll(groupBy(events, (e)=>e.startAt));
    return eventsByHours;
  }

  @action
  Future<void> add(Duration duration) async {
    currenDate = startDate.add(duration);
    load();
  }

  @action
  Future<void> load() async {
    events.clear();
    events.addAll(await this.eventService.getEvents(currenDate));
  }

}