// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlanningStore on _PlanningStore, Store {
  Computed<Map<DateTime, List<Event>>> _$eventsByHoursComputed;

  @override
  Map<DateTime, List<Event>> get eventsByHours => (_$eventsByHoursComputed ??=
          Computed<Map<DateTime, List<Event>>>(() => super.eventsByHours))
      .value;

  final _$currenDateAtom = Atom(name: '_PlanningStore.currenDate');

  @override
  DateTime get currenDate {
    _$currenDateAtom.context.enforceReadPolicy(_$currenDateAtom);
    _$currenDateAtom.reportObserved();
    return super.currenDate;
  }

  @override
  set currenDate(DateTime value) {
    _$currenDateAtom.context.conditionallyRunInAction(() {
      super.currenDate = value;
      _$currenDateAtom.reportChanged();
    }, _$currenDateAtom, name: '${_$currenDateAtom.name}_set');
  }

  final _$eventsAtom = Atom(name: '_PlanningStore.events');

  @override
  ObservableList<Event> get events {
    _$eventsAtom.context.enforceReadPolicy(_$eventsAtom);
    _$eventsAtom.reportObserved();
    return super.events;
  }

  @override
  set events(ObservableList<Event> value) {
    _$eventsAtom.context.conditionallyRunInAction(() {
      super.events = value;
      _$eventsAtom.reportChanged();
    }, _$eventsAtom, name: '${_$eventsAtom.name}_set');
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add(Duration duration) {
    return _$addAsyncAction.run(() => super.add(duration));
  }

  final _$loadAsyncAction = AsyncAction('load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    final string =
        'currenDate: ${currenDate.toString()},events: ${events.toString()},eventsByHours: ${eventsByHours.toString()}';
    return '{$string}';
  }
}
