// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  Computed<bool> _$loggedInComputed;

  @override
  bool get loggedIn =>
      (_$loggedInComputed ??= Computed<bool>(() => super.loggedIn)).value;

  final _$appBarTitleAtom = Atom(name: '_AppStore.appBarTitle');

  @override
  String get appBarTitle {
    _$appBarTitleAtom.context.enforceReadPolicy(_$appBarTitleAtom);
    _$appBarTitleAtom.reportObserved();
    return super.appBarTitle;
  }

  @override
  set appBarTitle(String value) {
    _$appBarTitleAtom.context.conditionallyRunInAction(() {
      super.appBarTitle = value;
      _$appBarTitleAtom.reportChanged();
    }, _$appBarTitleAtom, name: '${_$appBarTitleAtom.name}_set');
  }

  final _$selectedIndexAtom = Atom(name: '_AppStore.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.context.enforceReadPolicy(_$selectedIndexAtom);
    _$selectedIndexAtom.reportObserved();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.context.conditionallyRunInAction(() {
      super.selectedIndex = value;
      _$selectedIndexAtom.reportChanged();
    }, _$selectedIndexAtom, name: '${_$selectedIndexAtom.name}_set');
  }

  final _$userAtom = Atom(name: '_AppStore.user');

  @override
  ObservableFuture<User> get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(ObservableFuture<User> value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$selectedAsyncAction = AsyncAction('selected');

  @override
  Future<void> selected(int newValue) {
    return _$selectedAsyncAction.run(() => super.selected(newValue));
  }

  final _$setAppBatTitleAsyncAction = AsyncAction('setAppBatTitle');

  @override
  Future<void> setAppBatTitle(String title) {
    return _$setAppBatTitleAsyncAction.run(() => super.setAppBatTitle(title));
  }

  final _$fetchAccountAsyncAction = AsyncAction('fetchAccount');

  @override
  Future<User> fetchAccount() {
    return _$fetchAccountAsyncAction.run(() => super.fetchAccount());
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<User> login(String username, String password) {
    return _$loginAsyncAction.run(() => super.login(username, password));
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<User> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    final string =
        'appBarTitle: ${appBarTitle.toString()},selectedIndex: ${selectedIndex.toString()},user: ${user.toString()},loggedIn: ${loggedIn.toString()}';
    return '{$string}';
  }
}
