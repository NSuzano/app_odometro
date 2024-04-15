import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class ExpensesUtil {
  static Future<List<Expenses>> getExpenses(User user) async {
    try {
      var response = await http.get(Uri.parse("$kExpansesGet?type=expense"),
          headers: {"Accept": "application/json", "Authorization": User.token});
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
}
