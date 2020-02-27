import 'dart:convert';

import 'package:crossfitapp/event.dart';
import 'package:crossfitapp/planning/event.dart';
import 'package:crossfitapp/services/network.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EventService{

  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  static Future<List<Event>> getEvents(DateTime date) async {

    return await NetworkService.get("/protected/planning?view=day&start="+dateFormat.format(date))
    .then((http.Response response) {

      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .expand((data) => (data['events'] as List).map((data) => Event.fromJson(data)).toList())
            .toList();
      } 
      else {
        throw Exception('Failed to load post');
      }
    });

    
  }
}