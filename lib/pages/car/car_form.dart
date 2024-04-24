import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/user.dart';
import 'package:app_odometro/pages/car/car_utli.dart';
import 'package:app_odometro/util/loading_dialog.dart';
import 'package:app_odometro/util/providers/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CarForm extends StatefulWidget {
  const CarForm({super.key});

  @override
  State<CarForm> createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  // final TextEditingController _owner = TextEditingController();
  String? _selectedOption;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isDropdownError = false; // State to track if dropdown validation failed
  final data = Get.arguments;

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = data['user'];
    final carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Novo Carro",
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
          child: _buildForm(context, user, carProvider),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, User user, CarProvider carProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Adicionar Novo Carro",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDefaultColors,
                fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildTextFormField(_plateController, "Placa do Carro",
              Icons.featured_play_list_rounded),
          _buildTextFormField(
              _brandController, "Marca do Carro", Icons.car_crash_outlined),
          _buildTextFormField(
              _modelController, "Modelo do Carro", Icons.car_rental_outlined),
          _buildOwnerDropdown(),

          // Display error message if dropdown validation fails
          if (_isDropdownError)
            const Text(
              'Por favor selecione uma opção',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          const SizedBox(height: 16),
          _buildSubmitButton(context, user, carProvider),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      maxLength: label.contains("Placa") ? 8 : 40,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor digite a $label';
        }
        return null;
      },
    );
  }

  Widget _buildOwnerDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Propietário : "),
        const SizedBox(width: 10),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedOption,
            hint: const Text("Selecione uma opção"),
            items: const ['Particular', 'Empresa'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedOption = newValue;
                _isDropdownError = false; // Reset error on new selection
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, User user, CarProvider carProvider) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kDefaultColors, foregroundColor: Colors.white),
        onPressed: () => _handleSubmit(context, user, carProvider),
        child: const Text('Enviar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
      ),
    );
  }

  Future<void> _handleSubmit(
      BuildContext context, User user, CarProvider carProvider) async {
    if (!_formKey.currentState!.validate() || _selectedOption == null) {
      if (_selectedOption == null) {
        setState(() => _isDropdownError = true);
      }
      return;
    }

    showDialog(context: context, builder: (context) => const LoadingDialog());

    final jsonSend = {
      "plate": _plateController.text,
      "brand": _brandController.text,
      "model": _modelController.text,
      "owner": _selectedOption == "Particular" ? "driver" : "company",
      "user_id": user.id.toString(),
      "branch_id": "77"
    };

    try {
      await CarUtils.postCars(jsonSend, user);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Carro Adicionado Com Sucesso'),
          backgroundColor: Colors.green));
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e'), backgroundColor: Colors.red));
    } finally {
      carProvider.clearCars();
      await carProvider.fetchCars(user, 1);
      Navigator.pop(context); // Close the loading dialog
      Navigator.pop(context); // Pop the current page to return to the car list
    }
  }
}
