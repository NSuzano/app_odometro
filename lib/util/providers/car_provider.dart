import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/car/car_utli.dart';
import 'package:flutter/material.dart';

class CarProvider with ChangeNotifier {
  List<Car> _cars = [];
  int _currentPage = 1;
  bool _hasMore = true;

  List<Car> get cars => _cars;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  Future fetchCars(User user, int page) async {
    List<Car> listCars = await CarUtils.getCars(user, page);

    if (listCars.length < 10) {
      _hasMore = false;
    }
    _cars.addAll(listCars);
    _currentPage++;

    print("HAS MORE : $_hasMore");


    notifyListeners();
  }

  void addCar(Car race) {
    _cars.add(race);
    notifyListeners();
  }

  void removeCar(Car race) {
    _cars.remove(race);
    notifyListeners();
  }

  void setCars(List<Car> newRaces) {
    _cars = newRaces;
    notifyListeners();
  }

  void clearCars() {
    _cars.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}
