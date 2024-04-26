import 'dart:io';

import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/pages/expenses/util/util_expenses.dart';
import 'package:app_odometro/util/geolocator_util.dart';
import 'package:app_odometro/util/loading_dialog.dart';
import 'package:app_odometro/widgets/select_dropdown.dart';
import 'package:app_odometro/widgets/text_form_field.dart';
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
  late Driver driver;
  late List<Categories> categoriesList;
  late List<Categories> categoriesListGas;
  bool _isFirstDropdownError = false;
  bool _isSecondDropdownError = false;
  bool _isSelectedGas = false;
  String? _selectedGasOption;

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
    categoriesList = data['categories-list'];
    categoriesListGas = data['categories-gas'];
    driver = data['driver'];
    TextStyle style =
        TextStyle(fontSize: 12, color: Color.fromARGB(255, 175, 47, 37));

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
                  TextFormFieldStyled(
                      label: "Descrição",
                      controller: _descricaoNotaController,
                      icon: Icons.payment,
                      max: 50,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite a descrição da nota';
                        }
                        return null;
                      }),
                  TextFormFieldStyled(
                      label: "Código da nota",
                      controller: _codigoNotaController,
                      icon: Icons.note_sharp,
                      max: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o código da nota';
                        }
                        return null;
                      }),
                  TextFormFieldStyled(
                      label: "Valor da nota",
                      controller: _valorNotaController,
                      icon: Icons.monetization_on,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      format: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o valor da nota';
                        }
                        return null;
                      }),
                  const SizedBox(height: 16),
                  TextFormFieldStyled(
                      label: "Tipo de pagamento",
                      controller: _tipoPagamentoController,
                      icon: Icons.payment,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o tipo de pagamento';
                        }
                        return null;
                      }),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Tipo da Despesa: ",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SelectDrop(
                          categories: categoriesList,
                          hint: "Selecione o Tipo",
                          selectedValue: _selectedOption,
                          hasError: _isFirstDropdownError,
                          onChangedValue: (newValue) {
                            setState(() {
                              _selectedOption = newValue;
                              _isSelectedGas =
                                  _selectedOption == "1" ? true : false;
                              _isFirstDropdownError = false;
                            });
                          }),
                      if (_isFirstDropdownError)
                        Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Text("Por favor, selecione o tipo da despesa",
                                style: style),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isSelectedGas)
                    Column(
                      children: [
                        const Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Tipo da Combustível: ",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SelectDrop(
                            categories: categoriesListGas,
                            hint: "Selecione o Combustível",
                            selectedValue: _selectedGasOption,
                            hasError: _isSecondDropdownError,
                            onChangedValue: (newValue) {
                              setState(() {
                                _selectedGasOption = newValue;
                                _isSecondDropdownError = false;
                              });
                            }),
                        if (_isSecondDropdownError)
                          Row(
                            children: [
                              const SizedBox(
                                width: 12,
                              ),
                              Text("Por favor, selecione o tipo de combustível",
                                  style: style),
                            ],
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
                          if (_selectedOption == null) {
                            print("TESTE1");
                            setState(() {
                              _isFirstDropdownError = true;
                            });
                          } else if (_selectedGasOption == null &&
                              _selectedOption == "1") {
                            print("TESTE2");
                            setState(() {
                              _isSecondDropdownError = true;
                            });
                          } else if (_capturedImage == null) {
                            print("Sem imagem");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Selecione uma imagem antes de enviar.'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            print("OK");
                            // _sendItems();
                          }
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
                  style: TextStyle(color: Color.fromARGB(255, 175, 47, 37)),
                ),
        ],
      ),
    );
  }

  Future<void> _sendItems() async {
    print("TESTE");
    showDialog(
      context: context,
      builder: (context) => const LoadingDialog(),
    );

    var position = await UserLocation.determinePosition();

    _formKey.currentState!.save();

    String data =
        "${position.timestamp.year}-${position.timestamp.month}-${position.timestamp.day}";

    final jsonSend = {
      "description": _descricaoNotaController.text,
      "type": "expense",
      "category_id": _selectedOption,
      "branch_id": driver.branchId.toString(),
      "group_taxa_id": "",
      "user_id": user.id,
      "gross_amount": _valorNotaController.text,
      "due_date": data,
      "payment_id": "",
      "external_code": _codigoNotaController.text,
    };

    try {
      ExpensesUtil.postExpenses(jsonSend, user);
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: Colors.red));
    }
  }
}
