import 'dart:async';
import 'package:crossfitapp/model/wod.dart';
import 'package:crossfitapp/service/network_client.dart';
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';

class WodResultService{

  final NetworkClient _network;
  WodResultService(this._network);

  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

/*
  Future<List<Wod>> findAllWodAtDateWithMyResult(DateTime date) async {

    Response<List> response = await _network.get("/api/wod/" + dateFormat.format(date) + "/withMyResult");

    if (response.statusCode == 200) {
      return response.data.map((e) => Wod.fromJson(e)).toList();
    } 
    else {
      throw Exception('Failed to load post');
    }    
  }
*/
  Future<List<WodResultRanking>> getRanking(Wod wod) async {    
    Response<List> response = await _network.get("/api/wod/${wod.id}/ranking");

    if (response.statusCode == 200) {
      return response.data.map((e) => WodResultRanking.fromJson(e)).toList();
    } 
    else {
      throw Exception('Failed to load post');
    }  
  }

  Future<void> save(WodResult wodResult){
    
    return _network.put("/api/wod/${wodResult.wod.id}/results", data: {
      'id': wodResult.id,
      'date': dateFormat.format(wodResult.date),
      'division' : EnumToString.parse(wodResult.division),
      'category' : EnumToString.parse(wodResult.category),
      'totalCompleteRound' : wodResult.totalCompleteRound,
      'totalReps' : wodResult.totalReps,
      'totalMinute' : wodResult.totalMinute,
      'totalSecond' : wodResult.totalSecond,
      'totalLoadInKilo' : wodResult.totalLoadInKilo,
      'comments': wodResult.comments
    });

  }
}