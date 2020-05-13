
import 'package:crossfitapp/model/error.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/service/event_service.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'booking_store.g.dart';


class BookingStore = _BookingStore with _$BookingStore;

abstract class _BookingStore with Store{

  final DateFormat dateFormat = DateFormat("EEEEE dd 'à' HH:mm", "fr");
  
  final EventService eventService;

  _BookingStore(this.eventService, Booking b){
    this.booking = Observable(b);
  }

  @observable
  Observable<Booking> booking;

  @computed
  String get title => booking.value.event.timeslottype.name + " " +  dateFormat.format(booking.value.event.startAt);
  @computed
  String get startAt => dateFormat.format(booking.value.event.startAt);
  @computed
  String get bookedAt => "Vous êtes inscrit à ce créneau depuis le " + dateFormat.format(booking.value.createdAt);
  @computed
  ErrorMessage get error => booking.value.error;

  @computed
  bool get isBooked => this.booking.value != null && this.booking.value.id != null;

  @computed
  bool get isBookable => this.booking.value != null && this.booking.value.id == null && this.booking.value.subscriptionId != null;

  @action
  void book() {

  }


  @action
  Future<void> cancel() async{
    return eventService.cancelBooking(this.booking.value.id).then((_)async{
      this.booking = Observable(await eventService.prepareBooking(booking.value.event));
    });
  }
}