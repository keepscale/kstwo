
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/service/booking_service.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:mobx/mobx.dart';

part 'activite_store.g.dart';


class ActivitePageStore = _ActivitePageStore with _$ActivitePageStore;

abstract class _ActivitePageStore with Store{
  
  final BookingService bookingService;
  final WodResultService wodResultService;
  final AppStore appStore;
  _ActivitePageStore(this.bookingService, this.wodResultService, this.appStore);

  @observable
  ObservableList<Booking> incommingBookings = ObservableList<Booking>();

  @observable
  ObservableList<Booking> pastBookings = ObservableList<Booking>();

  @observable
  Observable<Booking> booking = Observable<Booking>(null);
  
  Wod wod;
  WodResult wodResult;

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


  int currentPage = 1;
  
  @observable
  bool isLoading = true;

  @computed
  int get totalBooking => this.incommingBookings.length + this.pastBookings.length;

  @action
  Future<void> load() async {
    isLoading = true;
    currentPage = 1;
    var iterable = await this.bookingService.getIncomingBooking();
    var iterable2 = await this.bookingService.getPastBooking(currentPage);

    incommingBookings.clear();
    pastBookings.clear();

    incommingBookings.addAll(iterable);
    pastBookings.addAll(iterable2);
    
    return Future.delayed(Duration(milliseconds: 100)).then((value) => {isLoading=false});
  }
  @action
  Future<void> loadMore() async {
    isLoading = true;
    currentPage++;
    var iterable2 = await this.bookingService.getPastBooking(currentPage);
    pastBookings.clear();
    pastBookings.addAll(iterable2);
    
    return Future.delayed(Duration(milliseconds: 100)).then((value) => {isLoading=false});
  }

  
  @action
  Future<void> selectWod(int index) async{
    isLoading = true;
    this.wod = this.booking.value.wods[index];
    this.wodResult = wod.myresultAtDate;
    var iterable = await this.wodResultService.getRanking(wod);
    rankings.clear();
    rankings.addAll(iterable);
    isLoading = false;
  }

  @action
  Future<void> editWodResult() async{
    if(wodResult == null){
      wodResult = new WodResult(
        wod: wod,
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
  Future<void> saveWodResult() {
    this.wodResult.category = category;
    this.wodResult.division = division;
    this.wodResult.totalMinute = totalMinute;
    this.wodResult.totalSecond = totalSecond;
    this.wodResult.totalCompleteRound = totalCompleteRound;
    this.wodResult.totalReps = totalReps;
    this.wodResult.totalLoadInKilo = totalLoadInKilo;
    this.wodResult.comments = comments;
    return this.wodResultService.save(this.wodResult).then((_)async{
    });
  }

}