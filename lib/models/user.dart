import 'dart:convert';
import 'dart:developer';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  int? id;
  String? name;
  String? email;
  int? status;
  static late String token;
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
    role = json['role'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  User.fromJsoExpanses(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['role'] = this.role;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static Future<User?> login(String email, String password) async {
    User? user;
    Map jsonPost = {"email": email, "password": password};
    try {
      var response = await http.post(Uri.parse(kLogin),
          headers: {"Accept": "application/json"}, body: jsonPost);
      Map jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      if (response.statusCode == 200) {
        Map<String, dynamic> userInfo =
            JwtDecoder.decode(jsonResponse['token']);

        token = jsonResponse['token'];

        user = User.fromJson(userInfo);

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
}
