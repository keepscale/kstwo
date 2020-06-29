
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:mobx/mobx.dart';

part 'result_store.g.dart';


class ResultStore = _ResultStore with _$ResultStore;

abstract class _ResultStore with Store{
  
  final WodResultService wodResultService;
  final AppStore appStore;

  _ResultStore(this.wodResultService, this.appStore);

  @observable
  bool isLoading = true;
  
  @observable
  Observable<Booking> booking = Observable<Booking>(null);

  @observable
  int currentWodIndex = 0;

  @observable
  ObservableList<WodResultRanking> rankings = ObservableList<WodResultRanking>();
  
  @observable
	double totalLoadInKilo;  
  @observable
  int totalMinute;
  @observable
  int totalSecond;
  @observable
  int totalCompleteRound;
  @observable
  int totalReps;
  @observable
  Category category;
  @observable
  Division division;
  @observable
  String comments;
  
  @computed
  Wod get currentWod{
    return booking.value.wods[this.currentWodIndex];
  }

  @action
  Future<void> selectWod(int index) async{
    isLoading = true;
    this.currentWodIndex = index;
    rankings.clear();
    rankings.addAll(await this.wodResultService.getRanking(this.currentWod));
  
    isLoading = false;
  }

  @action
  Future<void> edit() {
    WodResult wodResult = this.currentWod.myresultAtDate;
    if(wodResult == null){
      wodResult = new WodResult(
        wod: this.currentWod,
        date: booking.value.startAt,
        category: Category.RX, 
        division: this.appStore.user.value.title == "MR" ? Division.MEN : Division.WOMEN
      );
    }
    this.category = wodResult.category;
    this.division = wodResult.division;
    this.totalMinute = wodResult.totalMinute;
    this.totalSecond = wodResult.totalSecond;
    this.totalCompleteRound = wodResult.totalCompleteRound;
    this.totalReps = wodResult.totalReps;
    this.totalLoadInKilo = wodResult.totalLoadInKilo;
    this.comments = wodResult.comments;
   
  }

  @action
  Future<void> save() {
    if (this.currentWod.myresultAtDate == null){
      this.currentWod.myresultAtDate = new WodResult(
        wod: this.currentWod,
        date: booking.value.startAt,
      );
    }
    this.currentWod.myresultAtDate.category = category;
    this.currentWod.myresultAtDate.division = division;
    this.currentWod.myresultAtDate.totalMinute = totalMinute;
    this.currentWod.myresultAtDate.totalSecond = totalSecond;
    this.currentWod.myresultAtDate.totalCompleteRound = totalCompleteRound;
    this.currentWod.myresultAtDate.totalReps = totalReps;
    this.currentWod.myresultAtDate.totalLoadInKilo = totalLoadInKilo;
    this.currentWod.myresultAtDate.comments = comments;
    return this.wodResultService.save(this.currentWod.myresultAtDate).then((_)async{
    });
  }
}