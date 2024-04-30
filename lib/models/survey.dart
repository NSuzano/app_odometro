import 'package:app_odometro/models/car.dart';
import 'package:app_odometro/models/user.dart';

class Survey {
  int? id;
  List? items;
  String? fullAddress;
  String? description;
  int? carId;
  int? userId;
  String? type;
  String? status;
  String? classification;
  DateTime? scheduledOn;
  DateTime? completedOn;
  DateTime? approvedOn;
  DateTime? createdAt;
  DateTime? updatedAt;
  Car? car;
  User? user;

  Survey(
      {this.id,
      this.items,
      this.fullAddress,
      this.description,
      this.carId,
      this.userId,
      this.type,
      this.status,
      this.classification,
      this.scheduledOn,
      this.completedOn,
      this.approvedOn,
      this.createdAt,
      this.updatedAt,
      this.car,
      this.user});

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // items = json['items'].cast();
    // fullAddress = json['full_address'];
    // description = json['description'];
    // carId = json['car_id'];
    // userId = json['user_id'];
    // // type = json['type'];
    // status = json['status'];
    // classification = json['classification'];
    // createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updated_at']);
    car = json['car'] != null ? Car.fromJsonAlt(json['car']) : null;
    user = json['user'] != null ? User.fromJsonAlt(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['items'] = this.items;
    data['full_address'] = this.fullAddress;
    data['description'] = this.description;
    data['car_id'] = this.carId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['classification'] = this.classification;
    data['scheduled_on'] = this.scheduledOn;
    data['completed_on'] = this.completedOn;
    data['approved_on'] = this.approvedOn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
