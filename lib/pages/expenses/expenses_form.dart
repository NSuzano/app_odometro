import 'dart:io';

import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/models/payment.dart';
import 'package:app_odometro/pages/expenses/util/util_expenses.dart';
import 'package:app_odometro/util/formats/currency_input_formatter.dart';
import 'package:app_odometro/util/geolocator_util.dart';
import 'package:app_odometro/util/loading_dialog.dart';
import 'package:app_odometro/util/providers/expenses_provider.dart';
import 'package:app_odometro/widgets/select_dropdown.dart';
import 'package:app_odometro/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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

  File? _capturedImage;
  String? _selectedOption;
  String? _selectedGasOption;
  String? _selectedOptionPayment;

  late User user;
  late Driver driver;
  late List<Categories> categoriesList;
  late List<Categories> categoriesListGas;
  late List<Payment> paymentList;

  bool _isFirstDropdownError = false;
  bool _isSecondDropdownError = false;
  bool _isPaymentDropdownError = false;
  bool _isSelectedGas = false;

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
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    user = args['user'];
    categoriesList = args['categories-list'];
    categoriesListGas = args['categories-gas'];
    driver = args['driver'];
    paymentList = args['payment-list'];

    final expenseProvider = Provider.of<ExpenseProvider>(context);

    TextStyle style =
        const TextStyle(fontSize: 12, color: Color.fromARGB(255, 175, 47, 37));

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
                      format: [CurrencyInputFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o valor da nota';
                        }
                        return null;
                      }),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Tipo da Pagamento: ",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SelectDrop(
                          categories: paymentList,
                          hint: "Selecione o Tipo",
                          selectedValue: _selectedOptionPayment,
                          hasError: _isFirstDropdownError,
                          onChangedValue: (newValue) {
                            setState(() {
                              _selectedOptionPayment = newValue;
                              _isPaymentDropdownError = false;
                            });
                          }),
                      if (_isPaymentDropdownError)
                        Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Text("Por favor, selecione o tipo de pagamento",
                                style: style),
                          ],
                        ),
                    ],
                  ),
                  // TextFormFieldStyled(
                  //     label: "Tipo de pagamento",
                  //     controller: _tipoPagamentoController,
                  //     icon: Icons.payment,
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Por favor, digite o tipo de pagamento';
                  //       }
                  //       return null;
                  //     }),
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
                          if (_selectedOptionPayment == null) {
                            print("Não selecionado pagamento");
                            setState(() {
                              _isPaymentDropdownError = true;
                            });
                          } else if (_selectedOption == null) {
                            print("Não selecionado Categoria");

                            setState(() {
                              _isFirstDropdownError = true;
                            });
                          } else if (_selectedGasOption == null &&
                              _selectedOption == "1") {
                            print("Não selecionado Combustivel");

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
                            _sendItems(expenseProvider);
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

  Future<void> _sendItems(ExpenseProvider expenseProvider) async {
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
      "center_of_cost": _selectedOption,
      "branch_id": driver.branchId.toString(),
      "user_id": user.id.toString(),
      "gross_amount": _valorNotaController.text,
      "due_date": data,
      "payment_id": _selectedOptionPayment,
      "external_code": _codigoNotaController.text,
    };

    _selectedGasOption != null
        ? jsonSend["category_id"] = _selectedGasOption
        : null;

    print("Json Send: $jsonSend");

    try {
      String idResponse = await ExpensesUtil.postExpenses(jsonSend, user);

      String response = await ExpensesUtil.postImageExpenses(
          user, _capturedImage!, idResponse);

      expenseProvider.clearExpenses();
      await expenseProvider.fetchExpenses(user, 1);
      Navigator.pop(context); // Close the loading dialog
      Navigator.popUntil(context, (route) {
        if (route.settings.name == 'expensives_list') {
          return true;
        }
        return false;
      });

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Sucesso',
        text: response,
        confirmBtnText: "Fechar",
        confirmBtnColor: kDefaultColors,
      );
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog

      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro',
          text: e.toString(),
          confirmBtnText: "Fechar",
          confirmBtnColor: kDefaultColors);

      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('$e'), backgroundColor: Colors.red));
    }
  }
}
