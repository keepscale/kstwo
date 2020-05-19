

class TimeSlotStatus{
  final bool  canSubscribeNotification;
  final bool hasSubscribeNotification;
  final int count;
  final int max;

  TimeSlotStatus(this.canSubscribeNotification, this.hasSubscribeNotification, this.count, this.max);


  static TimeSlotStatus fromJson(data) {
    return TimeSlotStatus(data['canSubscribeNotification'],data['hasSubscribeNotification'],data['count'],data['max']);
  }

}