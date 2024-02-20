import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_odometro/pages/race/race_card.dart';
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
  TextEditingController controller = TextEditingController();
  String? _kilometragem;
  File? _capturedImage;
  List<Race> races = [];
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;
    user = data['user'];
    races = data['races'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registro de Corrida",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.offAndToNamed('/', arguments: {"user": user});
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildKilometragemField(),
                    const SizedBox(height: 20),
                    _buildImageUploadSection(),
                    const SizedBox(height: 30),
                    _buildSubmitButton(user, context),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 50,
              color: Colors.black,
            ),
            const Text(
              "Ultimo Registro",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDefaultColors,
                  fontSize: 20),
            ),
            Flexible(
                child: races.isNotEmpty
                    ? ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          Race? race;
                          race = races[races.length - 1];

                          return RaceCard(
                            race: race,
                          );
                        })
                    : const Text(""))
          ],
        ),
      ),
    );
  }

  Widget _buildKilometragemField() {
    return Column(
      children: [
        const Text(
          "Novo Registro",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: kDefaultColors, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.directions_car_filled_rounded),
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
      height: 130,
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
              ? Container(
                  height: 120,
                  width: 120,
                  child: Image.file(
                    _capturedImage!,
                    width: 150,
                    alignment: Alignment.center,
                  ),
                )
              : Container(
                  child: const Text(
                    "Sem foto",
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(User user, BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kDefaultColors, foregroundColor: Colors.white),
        onPressed: () => _onSubmitPressed(user, context),
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

  void _onSubmitPressed(User user, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_capturedImage == null) {
        // Show an error message if an image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione uma imagem antes de enviar.'),
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
          String response = await postRace(
              _kilometragem!,
              position.latitude.toString(),
              position.longitude.toString(),
              hora,
              data,
              user.id!,
              _capturedImage);

          races = [];
          controller.clear();
          _capturedImage = null;
          List<Race> listRaces = await RaceUtils.getRaces(user);

          for (Race race in listRaces) {
            log(race.kms.toString());
          }

          setState(() {
            races = listRaces;
          });

          ReusableSnackbar.showSnackbar(context, response, Colors.greenAccent);
        } catch (e) {
          ReusableSnackbar.showSnackbar(
              context, e.toString(), Colors.redAccent);
        } finally {
          Navigator.pop(context); // Close the loading dialog
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

      return jsonResponse['message'];
    } catch (e) {
      return Future.error(e);
    }
  }
}
