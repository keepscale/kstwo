
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';


class WodResultRanking{
  
  WodResultRanking({this.id, this.date, this.memberId, this.displayName, this.displayResult, this.loadInKilo, this.title, this.category});

  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  int id;
  DateTime date;
  int memberId;
  String displayName;
  String displayResult;
  double loadInKilo;
  String title;
  Category category;

  static WodResultRanking fromJson(data) {
    WodResultRanking e = WodResultRanking(
      id: data["id"],
      date: data['date'] != null ? dateFormat.parse(data['date']) : null,
      memberId: data["memberId"],
      displayName: data["displayName"],
      displayResult: data["displayResult"],
      loadInKilo: data["loadInKilo"],
      title: data["title"],
      category: EnumToString.fromString(Category.values, data['category'])  
    );
    return e;
  }
}

class WodResult{

  WodResult({this.id, this.date, this.wod, this.totalLoadInKilo, this.totalMinute, this.totalSecond, this.totalCompleteRound, this.totalReps, this.comments,
    this.category,
    this.division});

  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  int id;
  DateTime date;
  Wod wod;
    
  
	double totalLoadInKilo;
  int totalMinute;
  int totalSecond;
  
  int totalCompleteRound;
  int totalReps;

  String comments;

  Category category = Category.RX;
  Division division;

  static WodResult fromJson(data, wod) {
    WodResult e = WodResult(
      id: data["id"],
      wod: wod,
      date: data['date'] != null ? dateFormat.parse(data['date']) : null,
      totalLoadInKilo: data["totalLoadInKilo"],
      totalMinute: data["totalMinute"],
      totalSecond: data["totalSecond"],
      totalCompleteRound: data["totalCompleteRound"],
      totalReps: data["totalReps"],
      comments: data["comments"],
      category: EnumToString.fromString(Category.values, data['category'])  ,
    );
    return e;
  }
}

enum Score {FOR_TIME, FOR_ROUNDS_REPS, FOR_LOAD}

enum WodCategory {BENCHMARK, QUALIFIER, GIRL, HEROES, CUSTOM}
enum Category {RX, SCALED, CUSTOM}
enum Division {WOMEN, MEN, TEAM}

class Wod{

  Wod({this.id, this.name, this.category, this.score, this.description, this.myresultAtDate});

  int id;
  String name;
  WodCategory category;
  Score score;
  String description;
  
  WodResult myresultAtDate;


  static  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  static Wod fromJson(data) {
    Wod e = Wod(
      id: data["id"],
      name: data['name'] ,
      category: EnumToString.fromString(WodCategory.values, data['category'])  ,
      score: EnumToString.fromString(Score.values, data['score'])  ,
      description: data['description']
    );
    e.myresultAtDate = data["myresultAtDate"] == null ? null : WodResult.fromJson(data["myresultAtDate"], e);
    return e;
  }
}


