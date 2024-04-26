import 'package:app_odometro/models/categories.dart';
import 'package:flutter/material.dart';

class SelectDrop extends StatefulWidget {
  final List categories;
  final String hint;
  final String? selectedValue;
  final Function(String?) onChangedValue;
  final bool hasError;

  SelectDrop({
    Key? key,
    required this.categories,
    required this.hint,
    required this.onChangedValue,
    this.selectedValue,
    required this.hasError,
  }) : super(key: key);

  @override
  State<SelectDrop> createState() => _SelectDropState();
}

class _SelectDropState extends State<SelectDrop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.selectedValue,
                hint: Text(widget.hint,
                    style: TextStyle(color: Colors.grey.shade600)),
                icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                isExpanded: true,
                items: widget.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id.toString(),
                    child: Text(category.name ?? "",
                        style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: widget.onChangedValue,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ),
        // if (widget.hasError)
        //   const Padding(
        //     padding: EdgeInsets.only(left: 10),
        //     child: Text(
        //       'Por favor selecione uma opção',
        //       style: TextStyle(color: Colors.red, fontSize: 12),
        //     ),
        //   ),
      ],
    );
  }
}
