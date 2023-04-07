import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String? time;
  String flag;
  String? url;
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, this.url, this.isDayTime});

  Future<void> getTime() async {
    Logger.root.level = Level.ALL;

    final logger = Logger('getTime');

    try {
      logger.info('Data: ${url}, ${location}');
      var uri = Uri.http('worldtimeapi.org', '/api/timezone/$url');
      var response = await http.get(uri);
      logger.info('Response to request: ${response.body}');
      Map data = jsonDecode(response.body);
      DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS");
      DateFormat outputFormat = DateFormat('h:mm:ss a');
      DateTime now = inputFormat.parse(data['datetime']);
      isDayTime = now.toLocal().hour > 6 && now.toLocal().hour < 20 ? true : false;
      time = outputFormat.format(now.toLocal());
    } catch (error) {
      logger.severe("Found error in getTime(), errorType: ${error.runtimeType} and, error: ${error}");
      time = 'Could not get time data';
    }
  }
}
