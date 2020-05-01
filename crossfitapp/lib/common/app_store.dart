
import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/provider/auth_provider.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store{

  AuthApiProvider authApiProvider = AuthApiProvider();

  @observable 
  ObservableFuture<User> user = noUser;

  static ObservableFuture<User> noUser = ObservableFuture.value(null);

  @computed
  bool get loggedIn => user != noUser 
    && user.status == FutureStatus.fulfilled;

  @action
  Future<User> fetchAccount() async {
    
    final future = authApiProvider.account();
    user = ObservableFuture(future);

    return await future;
  }
  
  @action
  Future<User> login(String username, String password) async {
    
    return authApiProvider
      .login(email: username, password: password)
      .then((response) => fetchAccount());
  }

}