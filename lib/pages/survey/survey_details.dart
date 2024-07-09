import 'package:app_odometro/models/survey.dart';
import 'package:flutter/material.dart';

class SurveyDetails extends StatelessWidget {
  final Survey inspectionDetail;
  const SurveyDetails({super.key, required this.inspectionDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Vistoria"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Descrição'),
                    subtitle: Text(inspectionDetail.description ?? "-"),
                  ),
                  ListTile(
                    title: const Text('Status'),
                    subtitle: Text(inspectionDetail.status ?? "-"),
                  ),
                  ListTile(
                    title: const Text('Tipo'),
                    subtitle: Text(inspectionDetail.type ?? "-"),
                  ),
                  ListTile(
                    title: const Text('Classificação'),
                    subtitle: Text(inspectionDetail.classification ?? "-"),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Agendada para'),
              subtitle: Text(inspectionDetail.scheduledOn.toString()),
            ),
            ListTile(
              title: const Text('Concluída em'),
              subtitle: Text(inspectionDetail.completedOn.toString()),
            ),
            ListTile(
              title: const Text('Aprovada em'),
              subtitle: Text(inspectionDetail.approvedOn.toString()),
            ),
            ListTile(
              title: const Text('Placa do Carro'),
              subtitle: Text(inspectionDetail.car == null
                  ? "-"
                  : inspectionDetail.car!.plate!),
            ),
            ListTile(
              title: const Text('Marca do Carro'),
              subtitle: Text(inspectionDetail.car!.brand!),
            ),
            ListTile(
              title: const Text('Modelo do Carro'),
              subtitle: Text(inspectionDetail.car!.model!),
            ),
            ListTile(
              title: const Text('Status do Carro'),
              subtitle: Text(inspectionDetail.car!.status!),
            ),
            ListTile(
              title: const Text('Descrição do Carro'),
              subtitle: Text(inspectionDetail.car!.description == null
                  ? "-"
                  : inspectionDetail.car!.description!),
            ),
            ExpansionTile(
              title: const Text('Problemas Identificados'),
              children: inspectionDetail.items!
                  .map((item) => ListTile(
                        title: Text(item.name ?? "-"),
                        subtitle: Text(item.description ?? "-"),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
