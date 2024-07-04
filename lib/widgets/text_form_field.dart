import 'package:app_odometro/constraint/constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldStyled extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData icon;
  final int? max;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? format;

  TextFormFieldStyled({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.icon,
    this.max,
    this.keyboardType,
    this.format,
  }) : super(key: key);

  @override
  State<TextFormFieldStyled> createState() => _TextFormFieldStyledState();
}

class _TextFormFieldStyledState extends State<TextFormFieldStyled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Colors.grey.shade300, width: 1), // Borda visível
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5), // Borda quando o campo está não focado
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: kDefaultColors,
              width: 2), // Borda quando o campo está focado
        ),
      ),
      validator: widget.validator,
      maxLength: widget.max,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.format,
    );
  }
}
