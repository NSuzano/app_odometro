import 'package:app_odometro/constraint/constraint.dart';
import 'package:flutter/material.dart';

class LabelRace extends StatelessWidget {
  const LabelRace({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: kDefaultColors,
            ),
            Text(
              "Corrida Iniciada",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              color: Colors.green,
            ),
            Text(
              "Corrida Finalizada",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
