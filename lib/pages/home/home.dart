import 'package:app_odometro/pages/race/util_race.dart';
import 'package:app_odometro/util/card_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/race.dart';
import '../../models/user.dart';

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80, // Set this height
          elevation: 0,
          centerTitle: true,
          title: Text(user.name!),
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SizedBox(
              child: Image.asset(
                "assets/icons/icon_wp.png",
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    Get.offAndToNamed('login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout_outlined),
                  )),
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
              const SizedBox(
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
                        List<Race> races = await RaceUtils.getRaces(user);

                        Get.toNamed('race',
                            arguments: {"user": user, "races": races});
                      },
                      child: const CardHome(
                          image: "assets/icons/odometro.png",
                          text: "Registro de Corrida"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.toNamed('expensives', arguments: {"user": user});
                      },
                      child: const CardHome(
                          image: "assets/icons/honorarios.png",
                          text: "Outras Dispesas"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        List<Race> races = await RaceUtils.getRaces(user);

                        Get.toNamed('list-race',
                            arguments: {"user": user, "races": races});
                      },
                      child: const CardHome(
                          image: "assets/icons/honorarios.png",
                          text: "Lista de Registros"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
