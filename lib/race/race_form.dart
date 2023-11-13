import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RaceForm extends StatefulWidget {
  const RaceForm({super.key});

  @override
  State<RaceForm> createState() => _RaceFormState();
}

class _RaceFormState extends State<RaceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _kilometragem;
  String? _tipoCarro;
  String? _tipoMovimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Kilometragem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, insira a kilometragem";
                  }
                  return null;
                },
                onSaved: (value) {
                  _kilometragem = value;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _tipoCarro,
                onChanged: (value) {
                  setState(() {
                    _tipoCarro = value;
                  });
                },
                items: ['Carro Próprio', 'Carro da Empresa']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text('$tipo'),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Tipo de Carro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione o tipo de carro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _tipoMovimento,
                onChanged: (value) {
                  setState(() {
                    _tipoMovimento = value;
                  });
                },
                items: ['Entrada', 'Saída']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text('$tipo'),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Tipo de Movimento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione o tipo de movimento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.photo),
                  label: Text("Enviar Foto")),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Dados válidos, faça o que precisa aqui
                    print('Kilometragem: $_kilometragem');
                    print('Tipo de Carro: $_tipoCarro');
                    print('Tipo de Movimento: $_tipoMovimento');
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
