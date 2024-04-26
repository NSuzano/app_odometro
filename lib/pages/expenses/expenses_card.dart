import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/util/formats/date_br.dart';
import 'package:app_odometro/widgets/label_value.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ExpensesCard extends StatelessWidget {
  final Expenses expenses;
  const ExpensesCard({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    String data = formatDate(expenses.dueDate!);
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Coluna para o ícone
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
                      data,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ValueLabel(value: expenses.grossAmount!)
                    // AutoSizeText(expenses.grossAmount!)
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                AutoSizeText(
                  "Descrição: ${expenses.description!}",
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(expenses.category!.name!)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
