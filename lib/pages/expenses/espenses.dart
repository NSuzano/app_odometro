import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constraint/constraint.dart';
import '../../models/user.dart';
import '../../util/image_picker_class.dart';

class ExpansesPage extends StatefulWidget {
  const ExpansesPage({super.key});

  @override
  State<ExpansesPage> createState() => _ExpansesPageState();
}

class _ExpansesPageState extends State<ExpansesPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _codigoNotaController = TextEditingController();
  TextEditingController _valorNotaController = TextEditingController();
  TextEditingController _tipoPagamentoController = TextEditingController();
  File? _capturedImage;

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
    final data = Get.arguments;
    User user = data['user'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Outras Dispesas"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed('/', arguments: {"user": user});
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Formulário de despesas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDefaultColors,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _codigoNotaController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.note_sharp),
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
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _valorNotaController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on),
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
                        TextInputType.numberWithOptions(decimal: true),
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _tipoPagamentoController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.payment),
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
                  SizedBox(height: 16),
                  _buildImageUploadSection(),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is validated, perform your desired action here
                          // For example, you can save the form data to a database
                          // or navigate to the next screen.
                          print('Form is valid');
                        }
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
            onPressed: _onImageUploadPressed,
            icon: Icon(Icons.photo, color: Colors.redAccent),
            label: Text(
              "Enviar Foto",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 40),
          _capturedImage != null
              ? Container(
                  height: 120,
                  width: 120,
                  child: Image.file(
                    _capturedImage!,
                    width: 150,
                    alignment: Alignment.center,
                  ),
                )
              : Text(
                  "Tire uma foto da nota",
                  style: TextStyle(color: Colors.redAccent),
                ),
        ],
      ),
    );
  }
}
