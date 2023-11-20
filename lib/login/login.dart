import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/home/home.dart';
import 'package:app_odometro/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../util/loading_dialog.dart';

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
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200,
                      child: Image.asset("assets/icons/icon_wp.png")),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Digite seu email e senha",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
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
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
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
                              return LoadingDialog();
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
