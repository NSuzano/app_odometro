import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/login/login.dart';
import 'package:app_odometro/race/race_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/home.dart';

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
      },
    );
  }
}
