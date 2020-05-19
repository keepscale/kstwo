// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookingStore on _BookingStore, Store {
  Computed<String> _$titleComputed;

  @override
  String get title =>
      (_$titleComputed ??= Computed<String>(() => super.title)).value;
  Computed<String> _$startAtComputed;

  @override
  String get startAt =>
      (_$startAtComputed ??= Computed<String>(() => super.startAt)).value;
  Computed<String> _$bookedAtComputed;

  @override
  String get bookedAt =>
      (_$bookedAtComputed ??= Computed<String>(() => super.bookedAt)).value;
  Computed<String> _$freePlacesStatusComputed;

  @override
  String get freePlacesStatus => (_$freePlacesStatusComputed ??=
          Computed<String>(() => super.freePlacesStatus))
      .value;
  Computed<ErrorMessage> _$errorComputed;

  @override
  ErrorMessage get error =>
      (_$errorComputed ??= Computed<ErrorMessage>(() => super.error)).value;
  Computed<bool> _$isBookedComputed;

  @override
  bool get isBooked =>
      (_$isBookedComputed ??= Computed<bool>(() => super.isBooked)).value;
  Computed<bool> _$isBookableComputed;

  @override
  bool get isBookable =>
      (_$isBookableComputed ??= Computed<bool>(() => super.isBookable)).value;
  Computed<bool> _$canSubscribeNotificationComputed;

  @override
  bool get canSubscribeNotification => (_$canSubscribeNotificationComputed ??=
          Computed<bool>(() => super.canSubscribeNotification))
      .value;
  Computed<bool> _$hasSubscribeNotificationComputed;

  @override
  bool get hasSubscribeNotification => (_$hasSubscribeNotificationComputed ??=
          Computed<bool>(() => super.hasSubscribeNotification))
      .value;

  final _$bookingAtom = Atom(name: '_BookingStore.booking');

  @override
  Observable<Booking> get booking {
    _$bookingAtom.context.enforceReadPolicy(_$bookingAtom);
    _$bookingAtom.reportObserved();
    return super.booking;
  }

  @override
  set booking(Observable<Booking> value) {
    _$bookingAtom.context.conditionallyRunInAction(() {
      super.booking = value;
      _$bookingAtom.reportChanged();
    }, _$bookingAtom, name: '${_$bookingAtom.name}_set');
  }

  final _$cancelAsyncAction = AsyncAction('cancel');

  @override
  Future<void> cancel() {
    return _$cancelAsyncAction.run(() => super.cancel());
  }

  final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore');

  @override
  Future<void> book() {
    final _$actionInfo = _$_BookingStoreActionController.startAction();
    try {
      return super.book();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> subscribeNotification() {
    final _$actionInfo = _$_BookingStoreActionController.startAction();
    try {
      return super.subscribeNotification();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'booking: ${booking.toString()},title: ${title.toString()},startAt: ${startAt.toString()},bookedAt: ${bookedAt.toString()},freePlacesStatus: ${freePlacesStatus.toString()},error: ${error.toString()},isBooked: ${isBooked.toString()},isBookable: ${isBookable.toString()},canSubscribeNotification: ${canSubscribeNotification.toString()},hasSubscribeNotification: ${hasSubscribeNotification.toString()}';
    return '{$string}';
  }
}
