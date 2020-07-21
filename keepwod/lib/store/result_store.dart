
import 'package:keepwod/model/booking.dart';
import 'package:keepwod/model/wod.dart';
import 'package:keepwod/service/wod_result_service.dart';
import 'package:keepwod/store/app_store.dart';
import 'package:mobx/mobx.dart';

part 'result_store.g.dart';


class ResultStore = _ResultStore with _$ResultStore;

abstract class _ResultStore with Store{
  
  final WodResultService wodResultService;
  final AppStore appStore;
  final Booking booking;
  final Wod wod;

  _ResultStore(this.wodResultService, this.appStore, this.booking, this.wod);

  @observable
  bool isLoading = true;

  @observable
  bool liked = false;
  
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
  

  @action
  Future<void> loadRanking() async{
    isLoading = true;
    rankings.clear();
    rankings.addAll(await this.wodResultService.getRanking(this.wod));  
    isLoading = false;
  }

  @action
  Future<void> likeToggle(){
    this.liked = !liked;
  }

  @action
  Future<void> edit() {
    WodResult wodResult = this.wod.myresultAtDate;
    if(wodResult == null){
      wodResult = new WodResult(
        wod: this.wod,
        date: this.booking.startAt,
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
    WodResult wodResult = this.wod.myresultAtDate;
    if (wodResult == null){
      wodResult = new WodResult(
        wod: this.wod,
        date: booking.startAt,
      );
      this.wod.myresultAtDate = wodResult;
    }
    wodResult.category = category;
    wodResult.division = division;
    wodResult.totalMinute = totalMinute;
    wodResult.totalSecond = totalSecond;
    wodResult.totalCompleteRound = totalCompleteRound;
    wodResult.totalReps = totalReps;
    wodResult.totalLoadInKilo = totalLoadInKilo;
    wodResult.comments = comments;
    
    return this.wodResultService.save(wodResult).then((_){
      this.loadRanking();
    });
  }
}