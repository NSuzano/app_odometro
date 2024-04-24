import 'dart:convert';
import 'dart:developer';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/util/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class User {
  int? id;
  String? name;
  String? email;
  int? status;
  String? token;
  String? role;
  String? image;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.status,
      this.role,
      this.image,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    token = json['token'];
    role = json['role'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  User.fromJsonAlt(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['status'] = status;
    data['token'] = token;
    data['role'] = role;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static Future<User?> login(
      String email, String password, BuildContext context) async {
    User? user;
    Map jsonPost = {"email": email, "password": password};
    final provider = Provider.of<UserProvider>(context, listen: false);

    try {
      var response = await http.post(Uri.parse(kLogin),
          headers: {"Accept": "application/json"}, body: jsonPost);
      Map jsonResponse = jsonDecode(response.body);

      print("Json Response: $jsonResponse");

      if (response.statusCode == 200) {
        Map<String, dynamic> userInfo =
            JwtDecoder.decode(jsonResponse['token']);

        print("USER INFO: $userInfo");

        userInfo.addAll({"token": jsonResponse['token']});
        print("USER INFO TOKEN: $userInfo");

        user = User.fromJson(userInfo);

        print("Token: ${user.token}");
        provider.saveUserToPrefs(user);

        return user;
      } else {
        print(response.bodyBytes);
        throw jsonResponse['message'];
      }
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  static Future<List<User>> getAllUsersFromApi(User user) async {
    try {
      var response = await http.get(
        Uri.parse(kUserGet),
        headers: {"Accept": "application/json", "Authorization": user.token!},
      );
      Map jsonResponse = jsonDecode(response.body);

      print("Json Response: $jsonResponse");

      if (response.statusCode == 200) {
        List<dynamic> usersData = jsonResponse['users'];
        print("Users DATA: $usersData");

        // Convert the 'raceData' list into a list of Race objects
        List<User> users =
            usersData.map((data) => User.fromJson(data)).toList();

        return users;
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
