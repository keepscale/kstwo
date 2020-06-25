// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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

  final _$bookingAtom = Atom(name: '_ActivitePageStore.booking');

  @override
  Observable<Booking> get booking {
    _$bookingAtom.reportRead();
    return super.booking;
  }

  @override
  set booking(Observable<Booking> value) {
    _$bookingAtom.reportWrite(value, super.booking, () {
      super.booking = value;
    });
  }

  final _$rankingsAtom = Atom(name: '_ActivitePageStore.rankings');

  @override
  ObservableList<WodResultRanking> get rankings {
    _$rankingsAtom.reportRead();
    return super.rankings;
  }

  @override
  set rankings(ObservableList<WodResultRanking> value) {
    _$rankingsAtom.reportWrite(value, super.rankings, () {
      super.rankings = value;
    });
  }

  final _$totalLoadInKiloAtom =
      Atom(name: '_ActivitePageStore.totalLoadInKilo');

  @override
  double get totalLoadInKilo {
    _$totalLoadInKiloAtom.reportRead();
    return super.totalLoadInKilo;
  }

  @override
  set totalLoadInKilo(double value) {
    _$totalLoadInKiloAtom.reportWrite(value, super.totalLoadInKilo, () {
      super.totalLoadInKilo = value;
    });
  }

  final _$totalMinuteAtom = Atom(name: '_ActivitePageStore.totalMinute');

  @override
  int get totalMinute {
    _$totalMinuteAtom.reportRead();
    return super.totalMinute;
  }

  @override
  set totalMinute(int value) {
    _$totalMinuteAtom.reportWrite(value, super.totalMinute, () {
      super.totalMinute = value;
    });
  }

  final _$totalSecondAtom = Atom(name: '_ActivitePageStore.totalSecond');

  @override
  int get totalSecond {
    _$totalSecondAtom.reportRead();
    return super.totalSecond;
  }

  @override
  set totalSecond(int value) {
    _$totalSecondAtom.reportWrite(value, super.totalSecond, () {
      super.totalSecond = value;
    });
  }

  final _$totalCompleteRoundAtom =
      Atom(name: '_ActivitePageStore.totalCompleteRound');

  @override
  int get totalCompleteRound {
    _$totalCompleteRoundAtom.reportRead();
    return super.totalCompleteRound;
  }

  @override
  set totalCompleteRound(int value) {
    _$totalCompleteRoundAtom.reportWrite(value, super.totalCompleteRound, () {
      super.totalCompleteRound = value;
    });
  }

  final _$totalRepsAtom = Atom(name: '_ActivitePageStore.totalReps');

  @override
  int get totalReps {
    _$totalRepsAtom.reportRead();
    return super.totalReps;
  }

  @override
  set totalReps(int value) {
    _$totalRepsAtom.reportWrite(value, super.totalReps, () {
      super.totalReps = value;
    });
  }

  final _$categoryAtom = Atom(name: '_ActivitePageStore.category');

  @override
  Category get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$divisionAtom = Atom(name: '_ActivitePageStore.division');

  @override
  Division get division {
    _$divisionAtom.reportRead();
    return super.division;
  }

  @override
  set division(Division value) {
    _$divisionAtom.reportWrite(value, super.division, () {
      super.division = value;
    });
  }

  final _$commentsAtom = Atom(name: '_ActivitePageStore.comments');

  @override
  String get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(String value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
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

  final _$loadDetailAsyncAction = AsyncAction('_ActivitePageStore.loadDetail');

  @override
  Future<void> loadDetail(Booking b) {
    return _$loadDetailAsyncAction.run(() => super.loadDetail(b));
  }

  final _$selectWodAsyncAction = AsyncAction('_ActivitePageStore.selectWod');

  @override
  Future<void> selectWod(int index) {
    return _$selectWodAsyncAction.run(() => super.selectWod(index));
  }

  final _$editWodResultAsyncAction =
      AsyncAction('_ActivitePageStore.editWodResult');

  @override
  Future<void> editWodResult() {
    return _$editWodResultAsyncAction.run(() => super.editWodResult());
  }

  final _$_ActivitePageStoreActionController =
      ActionController(name: '_ActivitePageStore');

  @override
  Future<void> saveWodResult() {
    final _$actionInfo = _$_ActivitePageStoreActionController.startAction(
        name: '_ActivitePageStore.saveWodResult');
    try {
      return super.saveWodResult();
    } finally {
      _$_ActivitePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
incommingBookings: ${incommingBookings},
pastBookings: ${pastBookings},
booking: ${booking},
rankings: ${rankings},
totalLoadInKilo: ${totalLoadInKilo},
totalMinute: ${totalMinute},
totalSecond: ${totalSecond},
totalCompleteRound: ${totalCompleteRound},
totalReps: ${totalReps},
category: ${category},
division: ${division},
comments: ${comments},
isLoading: ${isLoading},
totalBooking: ${totalBooking}
    ''';
  }
}
