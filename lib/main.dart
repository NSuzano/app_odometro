import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/car/car_form.dart';
import 'package:app_odometro/pages/car/car_page.dart';
import 'package:app_odometro/pages/driver/driver_page.dart';
import 'package:app_odometro/pages/expenses/expenses_form.dart';
import 'package:app_odometro/pages/expenses/expenses_page.dart';
import 'package:app_odometro/pages/listrace/list_race.dart';
import 'package:app_odometro/pages/login/login.dart';
import 'package:app_odometro/pages/race/race_form.dart';
import 'package:app_odometro/pages/survey/survey_page.dart';
import 'package:app_odometro/util/providers/car_provider.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:app_odometro/util/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'pages/home/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => RaceProvider()),
    ChangeNotifierProvider(create: (context) => ExpenseProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CarProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool checkUser = false;

  @override
  Widget build(BuildContext context) {
    if (!checkUser) {
      context.read<UserProvider>().loadUserFromPrefs();
      checkUser = true;
      print("CHECK USER");
    }
    User user = Provider.of<UserProvider>(context).user;

    print("NAME${user.name}");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kDefaultColors,
        fontFamily: 'Montserrat',
      ),
      home: user.name == null ? Login() : const Home(),
      routes: {
        'home': (context) => const Home(),
        'login': (context) => Login(),
        'expensives': (context) => const ExpansesForms(),
        'expensives_list': (context) => const ExpensesPage(),
        'race': (context) => const RaceForm(),
        'list-race': (context) => const ListRace(),
        'survey-page': (context) => const SurveyPage(),
        'driver-page': (context) => const DriverPage(),
        'car-page': (context) => const CarPage(),
        'car-form': (context) => const CarForm(),
      },
    );
  }
}
