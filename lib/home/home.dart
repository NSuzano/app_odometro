import 'package:app_odometro/util/card_home.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [Icon(Icons.logout_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Registro de Dispesas Working Plus",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
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
                  CardHome(
                      image: "assets/icons/car.png",
                      text: "Registro de Corrida"),
                  CardHome(
                      image: "assets/icons/bill.png", text: "Outras Dispesas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
