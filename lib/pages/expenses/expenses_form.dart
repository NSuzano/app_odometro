import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constraint/constraint.dart';
import '../../models/user.dart';
import '../../util/image_picker_class.dart';

class ExpansesForms extends StatefulWidget {
  const ExpansesForms({super.key});

  @override
  State<ExpansesForms> createState() => _ExpansesFormsState();
}

class _ExpansesFormsState extends State<ExpansesForms> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoNotaController =
      TextEditingController();
  final TextEditingController _codigoNotaController = TextEditingController();
  final TextEditingController _valorNotaController = TextEditingController();
  final TextEditingController _tipoPagamentoController =
      TextEditingController();
  File? _capturedImage;
  String? _selectedOption;
  final data = Get.arguments;
  late User user;

  void _onImageUploadPressed() {
    pickImage(source: ImageSource.camera).then((value) {
      if (value != '') {
        setState(() {
          _capturedImage = File(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    user = data['user'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Dispesas",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Formulário de despesas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDefaultColors,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _descricaoNotaController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.text_fields_outlined),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Descrição",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 80,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor digite a descrição da nota';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _codigoNotaController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.note_sharp),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Código da nota",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor digite o código da nota';
                      }
                      return null;
                    },
                    maxLength: 20,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _valorNotaController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.monetization_on),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Valor da nota",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor digite o valor da nota';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tipoPagamentoController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.payment),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Tipo de pagamento",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor digite o tipo de pagamento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Categoria: "),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedOption,
                          hint: const Text("Selecione uma opção"),
                          items: <String>['Opção 1', 'Opção 2', 'Opção 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOption = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildImageUploadSection(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDefaultColors,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is validated, perform your desired action here
                          // For example, you can save the form data to a database
                          // or navigate to the next screen.
                          print('Form is valid');

                          // String type = "expense";
                        }
                      },
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDefaultColors, foregroundColor: Colors.white),
            onPressed: _onImageUploadPressed,
            icon: const Icon(Icons.photo, color: Colors.redAccent),
            label: const Text(
              "Enviar Foto",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 40),
          _capturedImage != null
              ? SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.file(
                    _capturedImage!,
                    width: 150,
                    alignment: Alignment.center,
                  ),
                )
              : const Text(
                  "Tire uma foto da nota",
                  style: TextStyle(color: Colors.redAccent),
                ),
        ],
      ),
    );
  }
}
