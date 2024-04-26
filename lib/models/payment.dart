import 'dart:convert';

import 'package:app_odometro/constraint/constraint.dart';
import 'package:app_odometro/models/user.dart';
import 'package:http/http.dart' as http;

class Payment {
  int? id;
  String? code;
  String? name;
  String? type;
  String? status;
  int? accountId;
  String? createdAt;
  String? updatedAt;
  Account? account;

  Payment(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.status,
      this.accountId,
      this.createdAt,
      this.updatedAt,
      this.account});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Payment.fromJsonAlt(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['status'] = status;
    data['account_id'] = accountId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }

  static Future<List<Payment>> getPayments(User user) async {
    try {
      var response = await http.get(Uri.parse(kGetPayments), headers: {
        "Accept": "application/json",
        "Authorization": user.token!
      });
      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Assuming the API response contains a 'data' field which is a list of races
        List<dynamic> paymentData = jsonResponse['data'];
        print("Payment DATA: $paymentData");

        // Convert the 'raceData' list into a list of Race objects
        List<Payment> payment =
            paymentData.map((data) => Payment.fromJson(data)).toList();

        return payment;
      } else {
        throw jsonResponse;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class Account {
  int? id;
  String? code;

  Account({this.id, this.code});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}
