
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/service/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store{

  final AuthService authService;
  _AppStore(this.authService);

  @observable 
  String appBarTitle;

  @observable
  int selectedIndex = 0;
  
  @action
  Future<void> selected(int newValue) async{
    selectedIndex = newValue;
  }

  @observable 
  ObservableFuture<User> user = noUser;

  static ObservableFuture<User> noUser = ObservableFuture.value(null);

  
  @computed
  bool get logginPending => user != noUser 
    && user.status == FutureStatus.pending;

  @computed
  bool get loggedIn => user != noUser 
    && user.status == FutureStatus.fulfilled;

  @action
  Future<void> setAppBatTitle(String title) async {
    this.appBarTitle = title;
  }

  @action
  Future<User> fetchAccount() async {
    
    final future = authService.account();
    user = ObservableFuture(future);

    return await future;
  }
  
  @action
  Future<User> login(String username, String password) async {
    
    await authService.logout();

    return authService
      .login(email: username, password: password)
      .then((response) => fetchAccount());
  }

  @action
  Future<User> logout() async {
    
    return authService
      .logout()
      .then((response) => fetchAccount());
  }

  


}