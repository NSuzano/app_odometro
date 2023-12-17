import 'package:flutter/material.dart';

import '../../constraint/constraint.dart';
import '../../models/race.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  const RaceCard({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: race.raceEnd == null ? Colors.red : kDefaultColors,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              double.parse(race.value!) > 0.00
                  ? "Valor: R\$ ${race.value} "
                  : 'Kilômetros Inicial: ${race.raceStart!.odometer} KM',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 8.0),
            race.status == 1
                ? Text(
                    "KM Inicial : ${race.raceStart!.odometer} - Km Final : ${race.raceEnd!.odometer}",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : SizedBox(),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data: ${race.raceStart!.date}', // Replace with actual date
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                SizedBox(width: 8.0),
                Text(
                  'Hora: ${race.raceStart!.time}', // Replace with actual time
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
