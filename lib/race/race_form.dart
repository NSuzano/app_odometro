import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../constraint/constraint.dart';
import '../models/user.dart';
import '../util/geolocator_util.dart';
import '../util/image_cropper_page.dart';
import '../util/image_picker_class.dart';
import '../util/loading_dialog.dart';
import '../util/modal_dialog.dart';
import '../util/recognization_page.dart';

class RaceForm extends StatefulWidget {
  const RaceForm({Key? key}) : super(key: key);

  @override
  State<RaceForm> createState() => _RaceFormState();
}

class _RaceFormState extends State<RaceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _kilometragem;
  File? _capturedImage;

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    User user = data['user'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Corrida"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Get.toNamed('/', arguments: {"user": user});
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildKilometragemField(),
                  SizedBox(height: 20),
                  _buildImageUploadSection(),
                  SizedBox(height: 20),
                  _buildSubmitButton(user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKilometragemField() {
    return Column(
      children: [
        Text(
          "Digite a kilometragem do Odômetro",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.directions_car_filled_rounded),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Kilometragem",
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
              return "Por favor, insira a kilometragem";
            }
            return null;
          },
          onSaved: (value) {
            _kilometragem = value;
          },
        ),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    return SizedBox(
      height: 90,
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
          SizedBox(width: 20),
          _capturedImage != null ? Image.file(_capturedImage!) : Text(""),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(User user) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _onSubmitPressed(user),
        child: Text(
          'Enviar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _onImageUploadPressed() {
    pickImage(source: ImageSource.camera).then((value) {
      if (value != '') {
        setState(() {
          _capturedImage = File(value);
        });
      }
    });
  }

  void _onSubmitPressed(User user) async {
    if (_formKey.currentState!.validate()) {
      if (_capturedImage == null) {
        // Show an error message if an image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, selecione uma imagem antes de enviar.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => const LoadingDialog(),
        );
        var position = await UserLocation.determinePosition();
        Navigator.pop(context);

        _formKey.currentState!.save();
        // Dados válidos, faça o que precisa aqui

        String data =
            "${position.timestamp!.year}-${position.timestamp!.month}-${position.timestamp!.day}";
        print(data);
        print(position.timestamp);
        String hora = DateFormat("hh:m:s").format(position.timestamp!);
        print(hora);

        await postRace(
            _kilometragem!,
            position.latitude.toString(),
            position.longitude.toString(),
            hora,
            data,
            user.id!,
            _capturedImage);
      }
    }
  }

  Future<String> postRace(String kilo, String lat, String long, String hora,
      String data, int userId, File? image) async {
    List<int> imageBytes = image!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    Map jsonPost = {
      "odometer": kilo,
      "latitude": lat,
      "longitude": long,
      "date": data,
      "time": hora,
      "user_id": userId.toString(),
      "voucher_file": base64Image
    };

    // log(jsonPost['voucher_file']);

    try {
      var response = await http.post(Uri.parse(kRacePost),
          headers: {"Accept": "application/json"}, body: jsonPost);
      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(jsonResponse['message']);
        return jsonResponse['message'];
      } else {
        print(jsonResponse['message']);
        throw Exception('Falha ao fazer o Envio');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
