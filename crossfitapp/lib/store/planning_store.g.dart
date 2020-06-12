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
      (_$hoursComputed ??= Computed<List<DateTime>>(() => super.hours,
              name: '_PlanningPageStore.hours'))
          .value;
  Computed<Map<DateTime, List<Event>>> _$eventsByHoursComputed;

  @override
  Map<DateTime, List<Event>> get eventsByHours => (_$eventsByHoursComputed ??=
          Computed<Map<DateTime, List<Event>>>(() => super.eventsByHours,
              name: '_PlanningPageStore.eventsByHours'))
      .value;

  final _$isLoadingAtom = Atom(name: '_PlanningPageStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$dateAtom = Atom(name: '_PlanningPageStore.date');

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$eventsAtom = Atom(name: '_PlanningPageStore.events');

  @override
  ObservableList<Event> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<Event> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_PlanningPageStore.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$prepareBookingAsyncAction =
      AsyncAction('_PlanningPageStore.prepareBooking');

  @override
  Future<BookingStore> prepareBooking(Event event) {
    return _$prepareBookingAsyncAction.run(() => super.prepareBooking(event));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
date: ${date},
events: ${events},
hours: ${hours},
eventsByHours: ${eventsByHours}
    ''';
  }
}
