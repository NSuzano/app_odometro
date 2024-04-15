import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/expenses.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExpensesForm extends StatefulWidget {
  const ExpensesForm({super.key});

  @override
  State<ExpensesForm> createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  late User user;
  List<Expenses> expenses = [];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final data = Get.arguments;
    user = data['user'];
    expenses = expenseProvider.expenses;

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
            "Lista de Despesas",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Todos os Registros",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDefaultColors,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kDefaultColors,
          foregroundColor: kDefaultColorWhite,
          onPressed: () async {
            Get.toNamed('expensives', arguments: {"user": user});
          },
          icon: const Icon(Icons.add),
          label: const Text("Nova Dispesa"),
        ));
  }
}
