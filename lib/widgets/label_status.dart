import 'package:flutter/material.dart';

class StatusLabel extends StatelessWidget {
  final String status;
  final Color backgroundColor;
  final double elevation;
  final double borderRadius;

  StatusLabel({
    Key? key,
    required this.status,
    required this.backgroundColor,
    this.elevation = 4.0,
    this.borderRadius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: backgroundColor, // Cor de fundo
          borderRadius:
              BorderRadius.circular(borderRadius), // Bordas arredondadas
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Colors.white, // Cor do texto
            fontWeight: FontWeight.bold, // Peso da fonte
          ),
        ),
      ),
    );
  }
}
