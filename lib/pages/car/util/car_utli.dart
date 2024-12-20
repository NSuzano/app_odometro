import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class CarUtils {
  static Future<List<Car>> getCars(User user, int page) async {
    try {
      var response = await http.get(Uri.parse("$kCars?page=$page"), headers: {
        "Accept": "application/json",
        "Authorization": user.token!
      });
      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        List<dynamic> carData = jsonResponse['data'];
        print("Car DATA: $carData");

        // Convert the 'raceData' list into a list of Race objects
        List<Car> cars = carData.map((data) => Car.fromJson(data)).toList();

        return cars;
      } else {
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> postCars(Map json, User user) async {
    try {
      // var jsonSend = jsonEncode(json);
      var response = await http.post(Uri.parse(kCars),
          headers: {"Accept": "application/json", "Authorization": user.token!},
          body: json);

      Map jsonResponse = jsonDecode(response.body);

      print(response.statusCode);

      if (response.statusCode == 201) {
        return jsonResponse["type"];
      } else {
        print("Erro: ${response.body}");

        throw jsonResponse["errors"];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
