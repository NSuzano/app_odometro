import 'package:app_odometro/models/survey.dart';
import 'package:app_odometro/widgets/label_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SurveyCard extends StatelessWidget {
  final Survey survey;
  const SurveyCard({super.key, required this.survey});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.featured_play_list),
          ),
          Container(
            width: 10,
            color: Colors.green,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      survey.description != null ? survey.description! : "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ValueLabel(value: "12")
                    // AutoSizeText(expenses.grossAmount!)
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                AutoSizeText(
                  "Descrição: ${survey.description!}",
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  "Endereço: ${survey.fullAddress!}",
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
