import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/survey.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class SurveyUtil {
  static Future<List<Survey>> getSurvey(User user, int page) async {
    String id = user.id.toString();

    try {
      var response = await http
          .get(Uri.parse("$kGetSurvey?user_id=$id&page=$page"), headers: {
        "Accept": "application/json",
        "Authorization": user.token!
      });

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        List<dynamic> surveyData = jsonResponse['data'];
        // print("RACE DATA: $raceData");
        print("OK");
        print(surveyData);

        List<Survey> survey =
            surveyData.map((data) => Survey.fromJson(data)).toList();

        return survey;
      } else {
        print("Error: $jsonResponse");
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
