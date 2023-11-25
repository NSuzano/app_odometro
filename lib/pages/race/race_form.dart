import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_odometro/pages/race/util_race.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../constraint/constraint.dart';
import '../../models/race.dart';
import '../../models/user.dart';
import '../../util/geolocator_util.dart';
import '../../util/image_cropper_page.dart';
import '../../util/image_picker_class.dart';
import '../../util/loading_dialog.dart';
import '../../util/modal_dialog.dart';
import '../../util/recognization_page.dart';
import '../../util/snackbar.dart';

class RaceForm extends StatefulWidget {
  const RaceForm({Key? key}) : super(key: key);

  @override
  State<RaceForm> createState() => _RaceFormState();
}

class _RaceFormState extends State<RaceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _kilometragem;
  File? _capturedImage;
  List<Race> races = [];

  void getRaces() async {
    List<Race> getRace = await RaceUtils.getRaces();

    setState(() {
      races = getRace;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRaces();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
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
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Text(
              "Ultimos Registros",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDefaultColors,
                  fontSize: 20),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: races.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    Race race = races[index];
                    print(index);
                    return Card(
                      color: kDefaultColors,
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${race.odometer} Kilômetros',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Data: ${race.date}', // Replace with actual date
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Hora: ${race.time}', // Replace with actual time
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKilometragemField() {
    return Column(
      children: [
        Text(
          "Novo Registro",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: kDefaultColors, fontSize: 20),
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

        _formKey.currentState!.save();
        // Dados válidos, faça o que precisa aqui

        String data =
            "${position.timestamp!.year}-${position.timestamp!.month}-${position.timestamp!.day}";
        print(data);
        print(position.timestamp);
        String hora = DateFormat("hh:mm:ss").format(position.timestamp!);
        print(hora);

        try {
          await postRace(
              _kilometragem!,
              position.latitude.toString(),
              position.longitude.toString(),
              hora,
              data,
              user.id!,
              _capturedImage);
        } catch (e) {
          if (e == "Registro inserido com sucesso") {
            ReusableSnackbar.showSnackbar(
                context, e.toString(), Colors.greenAccent);
            Navigator.pop(context);
          } else {
            ReusableSnackbar.showSnackbar(
                context, e.toString(), Colors.redAccent);
            Navigator.pop(context);
            Get.offAndToNamed('raceForm', arguments: {"user": user});
          }
        }
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

    print(jsonPost);

    try {
      var response = await http.post(Uri.parse(kRacePost),
          headers: {"Accept": "application/json"}, body: jsonPost);
      Map jsonResponse = jsonDecode(response.body);

      print("json Response $jsonResponse");

      throw jsonResponse['message'];
    } catch (e) {
      return Future.error(e);
    }
  }
}
