import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      var response = await get("http://worldtimeapi.org/api/timezone/$url");
      var body = jsonDecode(response.body);
      var datetime = body['datetime'];
      String utcOffset = body['utc_offset'].substring(1, 3);

      DateTime currentTime = DateTime.parse(datetime);
      currentTime = currentTime.add(Duration(hours: int.parse(utcOffset)));

      isDayTime = currentTime.hour > 6 && currentTime.hour < 20 ? true : false;
      time = DateFormat.jm().format(currentTime);
    } on Exception catch (e) {
      print("caught exception is = " + e.toString());
      time = "exception caught. time not available";
    }
  }
}
