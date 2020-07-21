
import 'dart:math';

import 'package:keepwod/model/error.dart';
import 'package:keepwod/model/event.dart';
import 'package:keepwod/model/booking.dart';
import 'package:keepwod/service/event_service.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'booking_store.g.dart';


class BookingStore = _BookingStore with _$BookingStore;

abstract class _BookingStore with Store{

  final DateFormat dateFormat = DateFormat("EEEEE dd 'à' HH:mm", "fr");
  
  final EventService eventService;

  _BookingStore(this.eventService, this.event, Booking b){
    this.booking = Observable(b);
  }

  final Event event;

  @observable
  Observable<Booking> booking;

  @computed
  String get title => event.timeslottype.name + " " +  dateFormat.format(event.startAt);
  @computed
  String get startAt => dateFormat.format(event.startAt);
  @computed
  String get bookedAt => isBooked ? "Vous êtes inscrit à ce créneau depuis le " + dateFormat.format(booking.value.createdAt) : "";
  @computed
  String get freePlacesStatus => "${event.totalAttendees}/${event.maxAttendees}";
  @computed
  ErrorMessage get error => booking.value.error;

  @computed
  bool get isBooked => this.booking.value?.id != null;

  @computed
  bool get isBookable => this.booking.value?.id == null && this.booking.value?.subscriptionId != null;

  @computed
  bool get canSubscribeNotification => this.booking.value?.timeSlotStatus?.canSubscribeNotification??false;
  @computed
  bool get hasSubscribeNotification => this.booking.value?.timeSlotStatus?.hasSubscribeNotification??false;

  @action
  Future<void> book() {
    return eventService.book(this.event, this.booking.value.subscriptionId).then((_)async{
      this.booking = Observable(await eventService.prepareBooking(event));
    });
  }
  @action
  Future<void> subscribeNotification() {
    return eventService.subscribeNotification(this.event).then((_)async{
      this.booking = Observable(await eventService.prepareBooking(event));
    });
  }

  @action
  Future<void> cancel() async{
    return eventService.cancelBooking(this.booking.value.id).then((_)async{
      this.booking = Observable(await eventService.prepareBooking(event));
    });
  }
}