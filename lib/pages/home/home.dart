import 'package:app_odometro/util/card_home.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constraint/constraint.dart';
import '../../models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _areButtonsVisible = false;

  // Variável para armazenar a opção selecionada
  String _selectedOption = 'Palio 209';

  // Lista de opções para o dropdown
  final List<String> _options = ['Palio 209', 'Sandeiro', 'Corsa 98'];

  void _toggleButtons() {
    setState(() {
      _areButtonsVisible = !_areButtonsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    final data = Get.arguments;
    User user;
    user = data['user'];

    print(user.email);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100, // Set this height
          elevation: 0,
          centerTitle: true,
          title: Text(
            user.name!,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kDefaultColors,
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SizedBox(
              child: Image.asset(
                "assets/icons/icon_wp.png",
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    Get.offAndToNamed('login');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.logout_outlined,
                      color: kDefaultColorWhite,
                    ),
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Carro: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kDefaultColors),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: _selectedOption,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    elevation: 16,
                    style: const TextStyle(
                        color: kDefaultColors, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 1,
                      color: kDefaultColors,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items:
                        _options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.car_rental),

                            Text(value),
                            // Indicador de status ativo
                            Icon(Icons.fiber_manual_record,
                                color: _selectedOption == value
                                    ? Colors.green
                                    : Colors.grey)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Dois cards por linha
                    crossAxisSpacing:
                        8.0, // Espaçamento horizontal entre os cards
                    mainAxisSpacing: 8.0, // Espaçamento vertical entre os cards
                  ),
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // List<Race> races = await RaceUtils.getRaces(user);
                        await raceProvider.fetchRaces(user);

                        Get.toNamed('list-race', arguments: {"user": user});
                      },
                      child: const CardHome(
                          image: "assets/icons/odometro.png",
                          text: "Registro de Corrida"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await expenseProvider.fetchExpenses(user);
                        Get.toNamed('expensives_list',
                            arguments: {"user": user});
                      },
                      child: const CardHome(
                          image: "assets/icons/honorarios.png",
                          text: "Dispesas"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.toNamed('survey-page', arguments: {"user": user});
                      },
                      child: const CardHome(
                          image: "assets/icons/honorarios.png",
                          text: "Vistoria"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (_areButtonsVisible)
              _buildFloatingActionButton(
                  "Vincular Motorista", Icons.person_add),
            if (_areButtonsVisible)
              _buildFloatingActionButton("Cadastrar Carro", Icons.car_rental),
            if (_areButtonsVisible)
              _buildFloatingActionButton("Cadastrar Categoria", Icons.category),
            _buildMainFloatingActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: FloatingActionButton.extended(
        backgroundColor: kDefaultColors,
        onPressed: () {
          // Implementar o que cada botão deve fazer
          print("$title pressed");
        },
        label: Text(
          title,
          style: const TextStyle(color: kDefaultColorWhite),
        ),
        icon: Icon(
          icon,
          color: kDefaultColorWhite,
        ),
      ),
    );
  }

  Widget _buildMainFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _toggleButtons,
      backgroundColor: kDefaultColors,
      foregroundColor: kDefaultColorWhite,
      child: Icon(_areButtonsVisible ? Icons.close : Icons.density_small_sharp),
    );
  }
}
