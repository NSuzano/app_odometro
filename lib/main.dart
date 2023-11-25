import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/pages/expenses/espenses.dart';
import 'package:app_odometro/pages/login/login.dart';
import 'package:app_odometro/pages/race/race_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: kDefaultColors, fontFamily: 'Montserrat'),
      initialRoute: 'login',
      routes: {
        '/': (context) => Home(),
        'login': (context) => Login(),
        'raceForm': (context) => RaceForm(),
        'expensives': (context) => ExpansesPage(),
      },
    );
  }
}
