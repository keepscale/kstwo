// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlanningPageStore on _PlanningPageStore, Store {
  Computed<List<DateTime>> _$hoursComputed;

  @override
  List<DateTime> get hours =>
      (_$hoursComputed ??= Computed<List<DateTime>>(() => super.hours)).value;
  Computed<Map<DateTime, List<Event>>> _$eventsByHoursComputed;

  @override
  Map<DateTime, List<Event>> get eventsByHours => (_$eventsByHoursComputed ??=
          Computed<Map<DateTime, List<Event>>>(() => super.eventsByHours))
      .value;

  final _$isLoadingAtom = Atom(name: '_PlanningPageStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$dateAtom = Atom(name: '_PlanningPageStore.date');

  @override
  DateTime get date {
    _$dateAtom.context.enforceReadPolicy(_$dateAtom);
    _$dateAtom.reportObserved();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.context.conditionallyRunInAction(() {
      super.date = value;
      _$dateAtom.reportChanged();
    }, _$dateAtom, name: '${_$dateAtom.name}_set');
  }

  final _$eventsAtom = Atom(name: '_PlanningPageStore.events');

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

  final _$loadAsyncAction = AsyncAction('load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},date: ${date.toString()},events: ${events.toString()},hours: ${hours.toString()},eventsByHours: ${eventsByHours.toString()}';
    return '{$string}';
  }
}
