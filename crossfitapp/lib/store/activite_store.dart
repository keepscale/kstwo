
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/service/booking_service.dart';
import 'package:crossfitapp/service/wod_result_service.dart';
import 'package:crossfitapp/store/app_store.dart';
import 'package:crossfitapp/store/result_store.dart';
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
  ResultStore editWodResult(Booking booking, Wod wod){
    ResultStore store = new ResultStore(this.wodResultService, this.appStore, booking, wod);
    return store;
  }
  

}