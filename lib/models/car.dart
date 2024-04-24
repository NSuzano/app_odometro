import 'package:app_odometro/models/branch.dart';
import 'package:app_odometro/models/user.dart';

class Car {
  int? id;
  String? plate;
  String? brand;
  String? model;
  String? description;
  String? status;
  String? owner;
  int? userId;
  int? branchId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? branch;
  User? user;

  Car(
      {this.id,
      this.plate,
      this.brand,
      this.model,
      this.description,
      this.status,
      this.owner,
      this.userId,
      this.branchId,
      this.createdAt,
      this.updatedAt,
      this.branch,
      this.user});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plate = json['plate'];
    brand = json['brand'];
    model = json['model'];
    description = json['description'];
    status = json['status'];
    owner = json['owner'];
    userId = json['user_id'];
    branchId = json['branch_id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    user = json['user'] != null ? User.fromJsonAlt(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plate'] = plate;
    data['brand'] = brand;
    data['model'] = model;
    data['description'] = description;
    data['status'] = status;
    data['owner'] = owner;
    data['user_id'] = userId;
    data['branch_id'] = branchId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
