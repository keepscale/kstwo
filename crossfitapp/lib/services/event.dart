import 'dart:async';
import 'dart:convert';

import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/services/network.dart';
import 'package:intl/intl.dart';

class EventService{

  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  static Future<List<Event>> getEvents(DateTime date) async {

    final response = await NetworkService.get("/protected/planning?view=day&start="+dateFormat.format(date));

    if (response.statusCode == 200) {
      List decode = (json.decode(response.body) as List);
      List jsonData = decode
                .expand(
                  (databytype) => (databytype['events'] as List).map(
                    (dataevent) => Event.fromJson(dataevent, databytype["type"], databytype["color"])
                  )
                  .where((event) => event.type != EventType.PAST &&  event.startAt.difference(date).inDays == 0)
                ).toList();

      return jsonData;
    } 
    else {
      throw Exception('Failed to load post');
    }
    
  }
}