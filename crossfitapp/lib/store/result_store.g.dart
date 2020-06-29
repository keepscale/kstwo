// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResultStore on _ResultStore, Store {
  Computed<Wod> _$currentWodComputed;

  @override
  Wod get currentWod =>
      (_$currentWodComputed ??= Computed<Wod>(() => super.currentWod,
              name: '_ResultStore.currentWod'))
          .value;

  final _$isLoadingAtom = Atom(name: '_ResultStore.isLoading');

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

  final _$bookingAtom = Atom(name: '_ResultStore.booking');

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

  final _$currentWodIndexAtom = Atom(name: '_ResultStore.currentWodIndex');

  @override
  int get currentWodIndex {
    _$currentWodIndexAtom.reportRead();
    return super.currentWodIndex;
  }

  @override
  set currentWodIndex(int value) {
    _$currentWodIndexAtom.reportWrite(value, super.currentWodIndex, () {
      super.currentWodIndex = value;
    });
  }

  final _$rankingsAtom = Atom(name: '_ResultStore.rankings');

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

  final _$totalLoadInKiloAtom = Atom(name: '_ResultStore.totalLoadInKilo');

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

  final _$totalMinuteAtom = Atom(name: '_ResultStore.totalMinute');

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

  final _$totalSecondAtom = Atom(name: '_ResultStore.totalSecond');

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
      Atom(name: '_ResultStore.totalCompleteRound');

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

  final _$totalRepsAtom = Atom(name: '_ResultStore.totalReps');

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

  final _$categoryAtom = Atom(name: '_ResultStore.category');

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

  final _$divisionAtom = Atom(name: '_ResultStore.division');

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

  final _$commentsAtom = Atom(name: '_ResultStore.comments');

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

  final _$selectWodAsyncAction = AsyncAction('_ResultStore.selectWod');

  @override
  Future<void> selectWod(int index) {
    return _$selectWodAsyncAction.run(() => super.selectWod(index));
  }

  final _$_ResultStoreActionController = ActionController(name: '_ResultStore');

  @override
  Future<void> edit() {
    final _$actionInfo =
        _$_ResultStoreActionController.startAction(name: '_ResultStore.edit');
    try {
      return super.edit();
    } finally {
      _$_ResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> save() {
    final _$actionInfo =
        _$_ResultStoreActionController.startAction(name: '_ResultStore.save');
    try {
      return super.save();
    } finally {
      _$_ResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
booking: ${booking},
currentWodIndex: ${currentWodIndex},
rankings: ${rankings},
totalLoadInKilo: ${totalLoadInKilo},
totalMinute: ${totalMinute},
totalSecond: ${totalSecond},
totalCompleteRound: ${totalCompleteRound},
totalReps: ${totalReps},
category: ${category},
division: ${division},
comments: ${comments},
currentWod: ${currentWod}
    ''';
  }
}
