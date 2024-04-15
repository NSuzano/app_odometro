import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/race/util_race.dart';
import 'package:flutter/material.dart';
import 'package:app_odometro/models/race.dart';

class RaceProvider with ChangeNotifier {
  List<Race> _races = [];

  List<Race> get races => _races;

  Future fetchRaces(User user) async {
    _races = await RaceUtils.getRaces(user);
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
}
