import 'package:app_odometro/util/formats/date_br.dart';
import 'package:flutter/material.dart';

import '../../constraint/constraint.dart';
import '../../models/race.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  const RaceCard({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    String brazilianDate = convertIsoDateToBrazilian(race.raceStart!.date!);

    return Card(
      color: race.raceEnd == null ? Colors.red : kDefaultColors,
      margin: const EdgeInsets.all(8.0),
      child: Row(
        // Mudança de Column para Row para posicionar o ícone à esquerda
        children: [
          // Coluna para o ícone
          Container(
            color: Colors.white, // Cor de fundo branca para o ícone

            // ignore: prefer_const_constructors
          ),
          Expanded(
            // Container expandido para os outros widgets
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    double.parse(race.value!) > 0.00
                        ? "Valor: R\$ ${race.value} "
                        : 'Kilômetros Inicial: ${race.raceStart!.odometer} KM',
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  race.status != "started"
                      ? Text(
                          "KM Inicial : ${race.raceStart!.odometer} - Km Final : ${race.raceEnd!.odometer}",
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data: $brazilianDate',
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Hora: ${race.raceStart!.time}',
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
