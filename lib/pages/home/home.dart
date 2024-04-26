import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/models/payment.dart';
import 'package:app_odometro/util/card_home.dart';
import 'package:app_odometro/util/loading_dialog.dart';
import 'package:app_odometro/util/providers/car_provider.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:app_odometro/util/providers/user_provider.dart';
import 'package:app_odometro/util/util_drivers_info.dart';
import 'package:app_odometro/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constraint/constraint.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final carProvider = Provider.of<CarProvider>(context);
    final user = Provider.of<UserProvider>(context).user;
    final userProvider = Provider.of<UserProvider>(context);

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
                    showCustomDialog(context, "Logout", "Desesa mesmo sair?",
                        () {
                      userProvider.cleanUserFromPrefs();
                      Get.offAndToNamed('login');
                    });
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
                        raceProvider.clearRaces();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const LoadingDialog();
                          },
                        );
                        Driver driverInfo =
                            await DriversInfoUtil.getDriver(user);
                        await raceProvider.fetchRaces(user, 1);
                        Navigator.pop(context);
                        Get.toNamed('list-race',
                            arguments: {"user": user, "driver": driverInfo});
                      },
                      child: const CardHome(
                          image: "assets/icons/odometro.png",
                          text: "Registro de Corrida"),
                    ),
                    GestureDetector(
                      onTap: () async {
                        expenseProvider.clearExpenses();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const LoadingDialog();
                          },
                        );
                        Driver driverInfo =
                            await DriversInfoUtil.getDriver(user);
                        List<Payment> payment = await Payment.getPayments(user);

                        await expenseProvider.fetchExpenses(user, 1);
                        Navigator.pop(context);
                        Get.toNamed('expensives_list', arguments: {
                          "user": user,
                          "driver": driverInfo,
                          "payment-list": payment
                        });
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
              _buildFloatingActionButton("Vincular Motorista", Icons.person_add,
                  "driver", carProvider),
            if (_areButtonsVisible)
              _buildFloatingActionButton(
                  "Cadastrar Carro", Icons.car_rental, "car", carProvider),
            _buildMainFloatingActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(
      String title, IconData icon, String heroTag, CarProvider carProvider) {
    final user = Provider.of<UserProvider>(context).user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: FloatingActionButton.extended(
        heroTag: heroTag, // Adiciona uma tag única para cada botão

        backgroundColor: kDefaultColors,
        onPressed: () async {
          _areButtonsVisible = false;
          // Implementar o que cada botão deve fazer
          print("$title pressed");

          if (title == "Cadastrar Carro") {
            showDialog(
              context: context,
              builder: (context) {
                return const LoadingDialog();
              },
            );
            carProvider.clearCars();

            await carProvider.fetchCars(user, 1);

            Navigator.pop(context);
            Get.toNamed('car-page');
          }
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
      heroTag: "mainFAB", // Adiciona uma tag única para o botão principal
      onPressed: _toggleButtons,
      backgroundColor: kDefaultColors,
      foregroundColor: kDefaultColorWhite,
      child: Icon(_areButtonsVisible ? Icons.close : Icons.density_small_sharp),
    );
  }
}
