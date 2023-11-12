import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final String image;
  final String text;
  const CardHome({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
