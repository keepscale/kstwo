import 'dart:async';

import 'package:crossfitapp/model/booking.dart';
import 'package:crossfitapp/model/event.dart';
import 'package:crossfitapp/model/timeslot.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class BookingService{

  final NetworkClient _network;
  BookingService(this._network);

  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future<List<Booking>> getIncomingBooking() async {

    Response<List> response = await _network.get("api/bookings");

    if (response.statusCode == 200) {
      return response.data.map((e) => Booking.fromJson(e)).toList();
    } 
    else {
      throw Exception('Failed to load post');
    }    
  }
  Future<List<Booking>> getPastBooking(int page) async {

    Response<List> response = await _network.get("api/bookings/pastbookings", queryParameters: {'page': page});

    if (response.statusCode == 200) {
      return response.data.map((e) => Booking.fromJson(e)).toList();
    } 
    else {
      throw Exception('Failed to load post');
    }    
  }


}