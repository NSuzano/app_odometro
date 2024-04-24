import 'package:app_odometro/models/branch.dart';
import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/models/user.dart';

class Driver {
  int? id;
  String? cpf;
  String? cnh;
  String? status;
  int? userId;
  int? carId;
  int? branchId;
  String? createdAt;
  String? updatedAt;
  User? user;
  Branch? branch;
  Car? car;

  Driver(
      {this.id,
      this.cpf,
      this.cnh,
      this.status,
      this.userId,
      this.carId,
      this.branchId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.branch,
      this.car});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpf = json['cpf'];
    cnh = json['cnh'];
    status = json['status'];
    userId = json['user_id'];
    carId = json['car_id'];
    branchId = json['branch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJsonAlt(json['user']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    // car = json['car'] != null ? Car.fromJson(json['car']) : null;
  }
}
