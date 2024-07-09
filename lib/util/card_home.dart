import 'package:app_odometro/constraint/constraint.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String image;
  final String text;
  const CardHome({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: kDefaultColors),
          ),
        ],
      ),
    );
  }
}
