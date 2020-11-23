import 'dart:developer';

import 'package:keepwod/model/box.dart';
import 'package:keepwod/model/user.dart';
import 'package:keepwod/service/auth_service.dart';
import 'package:keepwod/service/box_service.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final AuthService authService;
  final BoxService boxService;
  _AppStore(this.authService, this.boxService);

  @observable
  String appBarTitle;

  @observable
  int selectedIndex = 0;

  @action
  Future<void> selected(int newValue) async {
    selectedIndex = newValue;
  }

  @observable
  ObservableFuture<User> user = ObservableFuture.value(null);

  @observable
  ObservableFuture<Box> box = ObservableFuture.value(null);

  @computed
  bool get pending =>
      (user.value != null && user.status == FutureStatus.pending) ||
      (box.value != null && box.status == FutureStatus.pending);

  @computed
  bool get loggedIn =>
      user.value != null && user.status == FutureStatus.fulfilled;

  @action
  Future<void> setAppBatTitle(String title) async {
    this.appBarTitle = title;
  }

  @action
  Future<void> fetchBox() async {
    box = ObservableFuture(boxService.get());
  }

  @action
  Future<void> fetchAccount() async {
    user = ObservableFuture(authService.account());
  }

  @action
  Future<void> login(String username, String password) async {
    await authService.logout();

    return authService
        .login(email: username, password: password)
        .then((response) {
      fetchAccount();
    });
  }

  @action
  Future<void> logout() async {
    return authService.logout().then((response) => fetchAccount());
  }
}
