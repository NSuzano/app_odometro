import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/pages/expenses/expenses.dart';
import 'package:app_odometro/pages/expenses/expenses_page.dart';
import 'package:app_odometro/pages/listrace/list_race.dart';
import 'package:app_odometro/pages/login/login.dart';
import 'package:app_odometro/pages/race/race_form.dart';
import 'package:app_odometro/pages/survey/survey_page.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'pages/home/home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => RaceProvider()),
    ChangeNotifierProvider(create: (context) => ExpenseProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kDefaultColors,
        fontFamily: 'Montserrat',
      ),
      initialRoute: 'login',
      routes: {
        '/': (context) => const Home(),
        'login': (context) => Login(),
        'expensives': (context) => const ExpansesPage(),
        'expensives_list': (context) => const ExpensesForm(),
        'race': (context) => const RaceForm(),
        'list-race': (context) => const ListRace(),
        'survey-page': (context) => const SurveyPage(),
      },
    );
  }
}
