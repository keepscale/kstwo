
import 'package:crossfitapp/planning/event.dart';
import 'package:mobx/mobx.dart';

part 'booking_store.g.dart';


class BookingStore = _BookingStore with _$BookingStore;

abstract class _BookingStore with Store{

  _BookingStore(this.event, this.date, this.timeslotId, this.subscriptionId);

  Event event;

  @observable
  int id;

  @observable
  DateTime date;

  @observable
  int timeslotId;

  @observable
  int subscriptionId;

  @computed
  bool get isBooked => this.id != null;

  @computed
  bool get isBookable => this.id == null && this.subscriptionId != null;

  @action
  void book() {
    id = 12;
  }


  @action
  void cancel() {
    id = null; 
  }
}