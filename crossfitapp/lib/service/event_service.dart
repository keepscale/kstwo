import 'dart:async';
import 'dart:convert';

import 'package:crossfitapp/planning/event.dart';
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
      List jsonData = response.data
                .expand(
                  (databytype) => (databytype['events'] as List).map(
                    (dataevent) => Event.fromJson(dataevent, databytype["type"], databytype["color"])
                  )
                  .where((event) => event.type != EventType.PAST)
                ).toList();

      var eventToday = jsonData.where((event)=>event.startAt.difference(date).inDays == 0).toList();

      return eventToday.length == 0 ? jsonData : eventToday;
    } 
    else {
      throw Exception('Failed to load post');
    }
    
  }
}