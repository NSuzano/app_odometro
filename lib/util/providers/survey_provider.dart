import 'package:app_odometro/models/survey.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/survey/util/util_survey.dart';
import 'package:flutter/material.dart';

class SurveyProvider with ChangeNotifier {
  List<Survey> _survey = [];
  int _currentPage = 1;
  bool _hasMore = true;

  List<Survey> get survey => _survey;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  Future fetchSurvey(User user, int page) async {
    try {
      List<Survey> listRaces = await SurveyUtil.getSurvey(user, page);
      if (listRaces.length < 10) {
        _hasMore = false;
      }
      _survey.addAll(listRaces);

      print("SURVEY: $survey -  Length - ${survey.length}");
      _currentPage++;

      print("HAS MORE : $_hasMore");

      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  void addRace(Survey survey) {
    _survey.add(survey);
    notifyListeners();
  }

  void removeRace(Survey survey) {
    _survey.remove(survey);
    notifyListeners();
  }

  void setRaces(List<Survey> newSurvey) {
    _survey = newSurvey;
    notifyListeners();
  }

  void clearSurvey() {
    _survey.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}
