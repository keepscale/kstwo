// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActivitePageStore on _ActivitePageStore, Store {
  Computed<int> _$totalBookingComputed;

  @override
  int get totalBooking =>
      (_$totalBookingComputed ??= Computed<int>(() => super.totalBooking,
              name: '_ActivitePageStore.totalBooking'))
          .value;

  final _$incommingBookingsAtom =
      Atom(name: '_ActivitePageStore.incommingBookings');

  @override
  ObservableList<Booking> get incommingBookings {
    _$incommingBookingsAtom.reportRead();
    return super.incommingBookings;
  }

  @override
  set incommingBookings(ObservableList<Booking> value) {
    _$incommingBookingsAtom.reportWrite(value, super.incommingBookings, () {
      super.incommingBookings = value;
    });
  }

  final _$pastBookingsAtom = Atom(name: '_ActivitePageStore.pastBookings');

  @override
  ObservableList<Booking> get pastBookings {
    _$pastBookingsAtom.reportRead();
    return super.pastBookings;
  }

  @override
  set pastBookings(ObservableList<Booking> value) {
    _$pastBookingsAtom.reportWrite(value, super.pastBookings, () {
      super.pastBookings = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ActivitePageStore.isLoading');

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

  final _$loadAsyncAction = AsyncAction('_ActivitePageStore.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$loadMoreAsyncAction = AsyncAction('_ActivitePageStore.loadMore');

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  final _$_ActivitePageStoreActionController =
      ActionController(name: '_ActivitePageStore');

  @override
  ResultStore editWodResult(Booking booking, Wod wod) {
    final _$actionInfo = _$_ActivitePageStoreActionController.startAction(
        name: '_ActivitePageStore.editWodResult');
    try {
      return super.editWodResult(booking, wod);
    } finally {
      _$_ActivitePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
incommingBookings: ${incommingBookings},
pastBookings: ${pastBookings},
isLoading: ${isLoading},
totalBooking: ${totalBooking}
    ''';
  }
}
