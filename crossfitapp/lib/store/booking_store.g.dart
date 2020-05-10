// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookingStore on _BookingStore, Store {
  Computed<bool> _$isBookedComputed;

  @override
  bool get isBooked =>
      (_$isBookedComputed ??= Computed<bool>(() => super.isBooked)).value;
  Computed<bool> _$isBookableComputed;

  @override
  bool get isBookable =>
      (_$isBookableComputed ??= Computed<bool>(() => super.isBookable)).value;

  final _$idAtom = Atom(name: '_BookingStore.id');

  @override
  int get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$dateAtom = Atom(name: '_BookingStore.date');

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

  final _$timeslotIdAtom = Atom(name: '_BookingStore.timeslotId');

  @override
  int get timeslotId {
    _$timeslotIdAtom.context.enforceReadPolicy(_$timeslotIdAtom);
    _$timeslotIdAtom.reportObserved();
    return super.timeslotId;
  }

  @override
  set timeslotId(int value) {
    _$timeslotIdAtom.context.conditionallyRunInAction(() {
      super.timeslotId = value;
      _$timeslotIdAtom.reportChanged();
    }, _$timeslotIdAtom, name: '${_$timeslotIdAtom.name}_set');
  }

  final _$subscriptionIdAtom = Atom(name: '_BookingStore.subscriptionId');

  @override
  int get subscriptionId {
    _$subscriptionIdAtom.context.enforceReadPolicy(_$subscriptionIdAtom);
    _$subscriptionIdAtom.reportObserved();
    return super.subscriptionId;
  }

  @override
  set subscriptionId(int value) {
    _$subscriptionIdAtom.context.conditionallyRunInAction(() {
      super.subscriptionId = value;
      _$subscriptionIdAtom.reportChanged();
    }, _$subscriptionIdAtom, name: '${_$subscriptionIdAtom.name}_set');
  }

  final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore');

  @override
  void book() {
    final _$actionInfo = _$_BookingStoreActionController.startAction();
    try {
      return super.book();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancel() {
    final _$actionInfo = _$_BookingStoreActionController.startAction();
    try {
      return super.cancel();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'id: ${id.toString()},date: ${date.toString()},timeslotId: ${timeslotId.toString()},subscriptionId: ${subscriptionId.toString()},isBooked: ${isBooked.toString()},isBookable: ${isBookable.toString()}';
    return '{$string}';
  }
}
