import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/race/util/util_race.dart';
import 'package:flutter/material.dart';
import 'package:app_odometro/models/race.dart';

class RaceProvider with ChangeNotifier {
  List<Race> _races = [];
  int _currentPage = 1;
  bool _hasMore = true;

  List<Race> get races => _races;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  Future fetchRaces(User user, int _currentPage) async {
    List<Race> listRaces = await RaceUtils.getRaces(user, _currentPage);
    if (listRaces.length < 10) {
      _hasMore = false;
    }
    _races.addAll(listRaces);

    print("RACES: $races -  Length - ${races.length}");
    _currentPage++;

    print("HAS MORE : $_hasMore");

    notifyListeners();
  }

  void addRace(Race race) {
    _races.add(race);
    notifyListeners();
  }

  void removeRace(Race race) {
    _races.remove(race);
    notifyListeners();
  }

  void setRaces(List<Race> newRaces) {
    _races = newRaces;
    notifyListeners();
  }

  void clearRaces() {
    _races.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}
