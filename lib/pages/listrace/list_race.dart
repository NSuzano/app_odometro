import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/race.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/race/race_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../race/util_race.dart';

class ListRace extends StatefulWidget {
  const ListRace({super.key});

  @override
  State<ListRace> createState() => _ListRaceState();
}

class _ListRaceState extends State<ListRace> {
  late User user;
  List<Race> races = [];

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    user = data['user'];
    races = data['races'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Lista de Registros",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Todos os Registros",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDefaultColors,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              races.isNotEmpty
                  ? Flexible(
                      child: ListView.builder(
                          itemCount: races.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Race? race;
                            race = races[index];

                            print(index);
                            return RaceCard(
                              race: race,
                            );
                          }))
                  : const SizedBox(
                      height: 600,
                      child: Center(
                          child: Text(
                        "Sem registros",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kDefaultColors,
          onPressed: () async {
            List<Race> races = await RaceUtils.getRaces(user);

            Get.toNamed('race', arguments: {"user": user, "races": races});
          },
          child: const Icon(Icons.add),
        ));
  }
}
