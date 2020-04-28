import 'package:crossfitapp/model/user.dart';
import 'package:crossfitapp/repository/account_repository.dart';
import 'package:rxdart/subjects.dart';

class AccountBloc{
  final AccountRepository _repository = AccountRepository();
  final BehaviorSubject<User> _subject =
      BehaviorSubject<User>();

  getAccount() async {
    User response = await _repository.getAccount();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<User> get subject => _subject;
  
}
final accountBloc = AccountBloc();