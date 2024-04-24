import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class CategoriesUtil {
  static Future<List<Categories>> getCategories(User user, String type) async {
    try {
      var response = await http.get(Uri.parse("$kGetCategories?type=$type"),
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
        List<Categories> categories =
            data.map((data) => Categories.fromJson(data)).toList();

        return categories;
      } else {
        print("Error: $jsonResponse");
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
