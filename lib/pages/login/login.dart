import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/pages/home/home.dart';
import 'package:app_odometro/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../util/loading_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      width: 150,
                      child: Image.asset(
                        "assets/icons/icon_wp.png",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Digite seu email e senha",
                    style: TextStyle(
                        fontSize: 16,
                        color: kDefaultColors,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Senha",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDefaultColors,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                      elevation: 3, // Elevation/shadow
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const LoadingDialog();
                            });
                        // Handle login logic here
                        String email = emailController.text;
                        String password = passwordController.text;
                        // You can add your authentication logic here
                        try {
                          user = await User.login(email, password);

                          Navigator.pop(context);
                          Get.offAndToNamed('/', arguments: {"user": user});
                        } catch (e) {
                          ReusableSnackbar.showSnackbar(
                              context, "$e", Colors.redAccent);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 18, // Text size
                      ),
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
