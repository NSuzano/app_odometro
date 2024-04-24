import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/widgets/label_status.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final Car car;

  CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    String categoria = car.owner == "driver" ? "Particular" : "Empresa";
    String status = car.status == "active" ? "Ativo" : "Inativo";
    TextStyle styleDescription = const TextStyle(fontSize: 12, height: 2);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_car, size: 24.0),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${car.model}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: StatusLabel(
                    status: status,
                    backgroundColor: Colors.green,
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Usuário: ${car.user!.name}',
                  style: styleDescription,
                ),
                Text(
                  'Categoria: $categoria',
                  style: styleDescription,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Branch Name: ${car.branch!.name}',
                  style: styleDescription,
                ),
                Text(
                  'Placa: ${car.plate}',
                  style: styleDescription,
                ),
              ],
            )

            // Text(
            //   'Criado em: $criadoEm',
            //   style: styleDescription,
            // ),
            // Text(
            //   'Atualizado em: $atualizadoEm',
            //   style: styleDescription,
            // ),
          ],
        ),
      ),
    );
  }
}
