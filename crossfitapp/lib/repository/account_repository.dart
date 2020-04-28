import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/provider/account_provider.dart';

class AccountRepository{

  AccountApiProvider _apiProvider = AccountApiProvider();

  Future<User> getAccount(){
    return _apiProvider.account();
  }
}