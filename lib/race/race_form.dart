import 'package:app_odometro/home/home.dart';
import 'package:app_odometro/util/geolocator_util.dart';
import 'package:app_odometro/util/image_cropper_page.dart';
import 'package:app_odometro/util/image_picker_class.dart';
import 'package:app_odometro/util/loading_dialog.dart';
import 'package:app_odometro/util/modal_dialog.dart';
import 'package:app_odometro/util/recognization_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

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
      appBar: AppBar(
        title: Text("Registro de Corrida"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/');
            },
            child: Icon(Icons.arrow_back_rounded)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.directions_car_filled_rounded),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Kilometragem",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
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
                  SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          imagePickerModal(context, onCameraTap: () {
                            pickImage(source: ImageSource.camera).then((value) {
                              if (value != '') {
                                imageCroppedView(value, context).then((value) {
                                  if (value != "") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                RecognizePage(path: value)));
                                  }
                                });
                              }
                            });
                          }, onGalleryTap: () {
                            pickImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value != '') {
                                imageCroppedView(value, context).then((value) {
                                  if (value != "") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                RecognizePage(path: value)));
                                  }
                                });
                              }
                            });
                          });
                        },
                        icon: Icon(
                          Icons.photo,
                          color: Colors.redAccent,
                        ),
                        label: Text("Enviar Foto")),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingDialog();
                            },
                          );
                          var position = await UserLocation.determinePosition();
                          Navigator.pop(context);

                          _formKey.currentState!.save();
                          // Dados válidos, faça o que precisa aqui
                          print('Kilometragem: $_kilometragem');
                          print('Latitude: ${position.latitude} ');
                          print('Longitude: ${position.longitude} ');
                          print(
                              'Tempo: ${position.timestamp.day}/${position.timestamp.month}/${position.timestamp.year}');
                          print(
                              'Data: ${position.timestamp.hour}:${position.timestamp.minute}:${position.timestamp.second}');
                        }
                      },
                      child: Text('Enviar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
