import 'dart:async';

import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/model/timeslot.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class EventService{

  final NetworkClient _network;
  EventService(this._network);

  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future<List<Event>> getEvents(DateTime date) async {

    Response<List> response = await _network.get("/protected/planning?view=day&start="+dateFormat.format(date));

    if (response.statusCode == 200) {
      //List decode = (json.decode(response.data) as List);
      List<Event> jsonData = response.data
                .expand(
                  (databytype) => (databytype['events'] as List).map(
                    (dataevent) => Event.fromJson(dataevent, databytype["type"], databytype["color"])
                  )
                  .where((event) => event.type != EventType.PAST)
                ).toList();

      var eventToday = jsonData.where((event)=>event.startAt.difference(date).inDays == 0 && event.startAt.day == date.day).toList();

      return eventToday;
    } 
    else {
      throw Exception('Failed to load post');
    }
    
  }


  Future<Booking> prepareBooking(Event event) async {

    try{

      Response<dynamic> response = await _network.post("api/bookings", queryParameters: {'prepare':true}, data: {
        'date': dateFormat.format(event.startAt),
        'timeslotId': event.id
      });

      return Booking.fromJson(response.data);

    } on DioError catch(e) {
      Booking b = Booking.fromJson(e.response.data);
      b.timeSlotStatus = await timeSlotStatus(event);
      return b;
    }
  }

  
  Future<void> book(Event event, int subscriptionId) {
    return _network.post("api/bookings", data: {
        'date': dateFormat.format(event.startAt),
        'timeslotId': event.id,
        'subscriptionId': subscriptionId
      });
  }

  Future<TimeSlotStatus> timeSlotStatus(Event event){
    return _network.get("api/bookings/${dateFormat.format(event.startAt)}/${event.id}/status")
      .then((r)=>TimeSlotStatus.fromJson(r.data));
  }

  Future<void> subscribeNotification(Event event){
    return _network.post("api/bookings/${dateFormat.format(event.startAt)}/${event.id}/subscribe");
  }
  

  Future<void> cancelBooking(int id) async {
    return await _network.delete("api/bookings/$id");
  }
}