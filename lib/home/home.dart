import 'package:app_odometro/race/race_form.dart';
import 'package:app_odometro/race/util_race.dart';
import 'package:app_odometro/util/card_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/race.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    User user;
    user = data['user'];

    print(user.email);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Set this height
        elevation: 0,
        centerTitle: true,
        title: Text(user.name!),
        leading: SizedBox(
          child: Image.asset(
            "assets/icons/icon_wp.png",
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Get.offAndToNamed('login');
                },
                child: Icon(Icons.logout_outlined)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Registro de Dispesas Working Plus",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dois cards por linha
                  crossAxisSpacing:
                      8.0, // Espaçamento horizontal entre os cards
                  mainAxisSpacing: 8.0, // Espaçamento vertical entre os cards
                ),
                children: [
                  GestureDetector(
                    onTap: () async {
                      Get.toNamed('raceForm', arguments: {"user": user});
                    },
                    child: CardHome(
                        image: "assets/icons/car.png",
                        text: "Registro de Corrida"),
                  ),
                  CardHome(
                      image: "assets/icons/bill.png", text: "Outras Dispesas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
