import 'package:app_odometro/constraint/constraint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showCustomDialog(BuildContext context, String title, String message,
    void Function() onPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: kDefaultColors,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.black, // Black message color
            ),
          ),
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween, // Center the buttons

            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 35), // Preenchimento uniforme
                  backgroundColor: kDefaultColors, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Borda arredondada
                  ),
                  elevation: 3, // Altura da sombra
                ),
                onPressed: onPressed,
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.white, // Blue button text color
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20), // Preenchimento uniforme
                  backgroundColor: kDefaultColors, // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Borda arredondada
                  ),
                  elevation: 3, // Altura da sombra
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
