import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class DriversInfoUtil {
  static Future<Driver> getDriver(User user) async {
    String id = user.id.toString();

    try {
      var response = await http.get(Uri.parse("$kGetDriversInfo/$id"),
          headers: {
            "Accept": "application/json",
            "Authorization": user.token!
          });

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        var data = jsonResponse['record'];
        // print("RACE DATA: $raceData");
        print("OK");

        // Convert the 'raceData' list into a list of Race objects
        Driver driver = Driver.fromJson(data);

        return driver;
      } else {
        print("Error: $jsonResponse");
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
