// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  Computed<bool> _$logginPendingComputed;

  @override
  bool get logginPending =>
      (_$logginPendingComputed ??= Computed<bool>(() => super.logginPending,
              name: '_AppStore.logginPending'))
          .value;
  Computed<bool> _$loggedInComputed;

  @override
  bool get loggedIn => (_$loggedInComputed ??=
          Computed<bool>(() => super.loggedIn, name: '_AppStore.loggedIn'))
      .value;

  final _$appBarTitleAtom = Atom(name: '_AppStore.appBarTitle');

  @override
  String get appBarTitle {
    _$appBarTitleAtom.reportRead();
    return super.appBarTitle;
  }

  @override
  set appBarTitle(String value) {
    _$appBarTitleAtom.reportWrite(value, super.appBarTitle, () {
      super.appBarTitle = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: '_AppStore.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$userAtom = Atom(name: '_AppStore.user');

  @override
  ObservableFuture<User> get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ObservableFuture<User> value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$selectedAsyncAction = AsyncAction('_AppStore.selected');

  @override
  Future<void> selected(int newValue) {
    return _$selectedAsyncAction.run(() => super.selected(newValue));
  }

  final _$setAppBatTitleAsyncAction = AsyncAction('_AppStore.setAppBatTitle');

  @override
  Future<void> setAppBatTitle(String title) {
    return _$setAppBatTitleAsyncAction.run(() => super.setAppBatTitle(title));
  }

  final _$fetchAccountAsyncAction = AsyncAction('_AppStore.fetchAccount');

  @override
  Future<User> fetchAccount() {
    return _$fetchAccountAsyncAction.run(() => super.fetchAccount());
  }

  final _$loginAsyncAction = AsyncAction('_AppStore.login');

  @override
  Future<User> login(String username, String password) {
    return _$loginAsyncAction.run(() => super.login(username, password));
  }

  final _$logoutAsyncAction = AsyncAction('_AppStore.logout');

  @override
  Future<User> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
appBarTitle: ${appBarTitle},
selectedIndex: ${selectedIndex},
user: ${user},
logginPending: ${logginPending},
loggedIn: ${loggedIn}
    ''';
  }
}
