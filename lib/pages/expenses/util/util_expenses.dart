import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class ExpensesUtil {
  static Future<List<Expenses>> getExpenses(User user, int page) async {
    print("PAGE: $page");

    String id = user.id.toString();
    try {
      var response = await http.get(
          Uri.parse("$kExpanses?type=expense&page=$page&user_id=$id"),
          headers: {
            "Accept": "application/json",
            "Authorization": user.token!
          });
      Map jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        List<dynamic> expensesData = jsonResponse['data'];
        print("Expenses DATA: $expensesData");

        // Convert the 'raceData' list into a list of Race objects
        List<Expenses> expenses =
            expensesData.map((data) => Expenses.fromJson(data)).toList();

        return expenses;
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> postExpenses(Map json, User user) async {
    try {
      var response = await http.post(Uri.parse(kExpanses),
          headers: {"Accept": "application/json", "Authorization": user.token!},
          body: json);

      Map jsonResponse = jsonDecode(response.body);

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("Dispesa Criada");
        return jsonResponse["message"];
      } else {
        print("Erro: ${response.body}");

        throw jsonResponse["errors"];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
