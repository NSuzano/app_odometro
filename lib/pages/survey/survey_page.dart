import 'package:flutter/material.dart';

import '../../constraint/constraint.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
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
            "Vistoria",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Text(
              "Todos as Vistorias",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDefaultColors,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
