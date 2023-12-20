import 'dart:convert';

import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

import '../../constraint/constraint.dart';
import '../../models/race.dart';

class RaceUtils {
  static Future<List<Race>> getRaces(User user) async {
    Map json = {"user_id": user.id.toString()};

    var jsonSend = jsonEncode(json);
    List<Race> race;
    try {
      var response = await http
          .get(Uri.parse(kRaceGet), headers: {"Accept": "application/json"});
      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        List<dynamic> raceData = jsonResponse['data'];
        print(raceData);

        // Convert the 'raceData' list into a list of Race objects
        List<Race> races = raceData.map((data) => Race.fromJson(data)).toList();

        return races;
      } else {
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}