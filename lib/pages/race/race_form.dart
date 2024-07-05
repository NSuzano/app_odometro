import 'dart:convert';
import 'dart:io';

import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/driver.dart';
import 'package:app_odometro/pages/race/race_card.dart';
import 'package:app_odometro/util/providers/races_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../constraint/constraint.dart';
import '../../models/race.dart';
import '../../models/user.dart';
import '../../util/geolocator_util.dart';
import '../../util/image_picker_class.dart';
import '../../util/loading_dialog.dart';

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
  late User user;
  List<Race> races = [];
  List<Categories> categoriesList = [];
  late Driver driver;
  String? _selectedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;

    user = args['user'];
    categoriesList = args['categories-list'];
    driver = args['driver'];

    races = raceProvider.races;
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
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildKilometragemField(),
                    const SizedBox(height: 20),
                    _buildImageUploadSection(),
                    const SizedBox(height: 16),
                    _buildDropDownSelect(),
                    const SizedBox(height: 30),
                    _buildSubmitButton(user, context, raceProvider),
                  ],
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
              SizedBox(
                  height: 170,
                  child: races.isNotEmpty
                      ? ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            Race? race;
                            race = races[0];

                            return RaceCard(
                              race: race,
                            );
                          })
                      : const Text(""))
            ],
          ),
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5), // Borda quando o campo está não focado
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: kDefaultColors,
                  width: 2), // Borda quando o campo está focado
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
                  "Sem foto",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }

  Widget _buildDropDownSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Text("Categoria: "),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value:
                _selectedOption, // Este deverá ser o id ou nome da categoria selecionada
            hint: const Text("Selecione uma opção"),
            items: categoriesList.map((Categories category) {
              return DropdownMenuItem<String>(
                value: category.id
                    .toString(), // Assumindo que você quer usar o nome como valor
                child:
                    Text(category.name ?? ""), // Exibindo o nome da categoria
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption =
                    newValue; // Atualizando o estado com a nova seleção
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
      User user, BuildContext context, RaceProvider raceProvider) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kDefaultColors, foregroundColor: Colors.white),
        onPressed: () => _onSubmitPressed(user, context, raceProvider),
        child: const Text(
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

  void _onSubmitPressed(
      User user, BuildContext context, RaceProvider raceProvider) async {
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
      } else if (_selectedOption == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione uma categoria antes de enviar.'),
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
            "${position.timestamp.year}-${position.timestamp.month}-${position.timestamp.day}";
        String hora = DateFormat("hh:mm:ss").format(position.timestamp);

        try {
          String response = await postRace(
              _kilometragem!,
              position.latitude.toString(),
              position.longitude.toString(),
              hora,
              data,
              user.id!,
              _capturedImage);

          controller.clear();
          _capturedImage = null;
          Navigator.pop(context); // Close the loading dialog

          // ReusableSnackbar.showSnackbar(context, response, Colors.green);
          raceProvider.clearRaces();
          // // print(user.name);
          // // return;

          await raceProvider.fetchRaces(user, 1);

          Navigator.popUntil(context, (route) {
            if (route.settings.name == 'list-race') {
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

          // ReusableSnackbar.showSnackbar(
          //     context, e.toString(), Colors.redAccent);
        } finally {
          // Get.offAllNamed("home", arguments: {"user": user});
        }
      }
    }
  }

  Future<String> postRace(String kilo, String lat, String long, String hora,
      String data, int userId, File? image) async {
    try {
      // Criar um request Multipart
      var request = http.MultipartRequest('POST', Uri.parse(kRacePost));

      // Adicionar o arquivo ao campo 'file' da requisição
      request.files.add(await http.MultipartFile.fromPath(
        'file', // Nome do campo (deve coincidir com o esperado pelo servidor)
        image!.path, // Caminho para o arquivo
      ));

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": user.token!
      });

      // Adicionar outros campos se necessário
      request.fields['odometer'] = kilo;
      request.fields['latitude'] = lat;
      request.fields['longitude'] = long;
      request.fields['date'] = data;
      request.fields['time'] = hora;
      request.fields['user_id'] = userId.toString();
      request.fields['branch_id'] = driver.branchId.toString();
      request.fields['category_id'] = _selectedOption!;
      request.fields['file'] = image.path;

      // Enviar a requisição e aguardar a resposta
      var response = await request.send();

      // Convert the StreamedResponse to a Response
      http.Response responseStream = await http.Response.fromStream(response);

      Map jsonResponse = jsonDecode(responseStream.body);

      if (response.statusCode == 201) {
        return jsonResponse['message'];
      } else {
        print(jsonResponse['errors'][0]);
        throw jsonResponse['errors'][0];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
