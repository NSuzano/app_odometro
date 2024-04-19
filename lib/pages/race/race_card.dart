import 'package:app_odometro/util/formats/date_br.dart';
import 'package:flutter/material.dart';

import '../../constraint/constraint.dart';
import '../../models/race.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  const RaceCard({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    String brazilianDate = convertIsoDateToBrazilian(
        race.raceStart!.date!); // Supondo que a função converta corretamente

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Faz os filhos preencherem o espaço
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  decoration: BoxDecoration(
                      color:
                          race.raceEnd == null ? kDefaultColors : Colors.green,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            race.status == "completed"
                                ? "Valor: R\$ ${race.value} "
                                : 'KM Inicial: ${race.raceStart!.odometer} KM',
                            style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          race.status == "completed"
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : const Text("")
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      race.status != "started"
                          ? Text(
                              "KM Inicial : ${race.raceStart!.odometer} - Km Final : ${race.raceEnd!.odometer}",
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data: $brazilianDate',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Hora: ${race.raceStart!.time}',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
