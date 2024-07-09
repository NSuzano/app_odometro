import 'package:app_odometro/models/user.dart';

class Survey {
  int? id;
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
  List<Items>? items;

  Survey(
      {this.id,
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
      this.user,
      this.items});

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullAddress = json['full_address'] ?? "-";
    description = json['description'] ?? "-";
    carId = json['car_id'];
    userId = json['user_id'];
    type = json['type'] ?? "-";
    status = json['status'] ?? "-";
    classification = json['classification'] ?? "-";
    scheduledOn = json['scheduled_on'];
    completedOn = json['completed_on'];
    approvedOn = json['approved_on'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_address'] = fullAddress;
    data['description'] = description;
    data['car_id'] = carId;
    data['user_id'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['classification'] = classification;
    data['scheduled_on'] = scheduledOn;
    data['completed_on'] = completedOn;
    data['approved_on'] = approvedOn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Car {
  int? id;
  String? plate;
  String? brand;
  String? model;
  String? status;
  String? description;

  Car(
      {this.id,
      this.plate,
      this.brand,
      this.model,
      this.status,
      this.description});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plate = json['plate'] ?? "-";
    brand = json['brand'] ?? "-";
    model = json['model'] ?? "-";
    status = json['status'] ?? "-";
    description = json['description'] ?? "-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plate'] = plate;
    data['brand'] = brand;
    data['model'] = model;
    data['status'] = status;
    data['description'] = description;
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? description;
  Pivot? pivot;

  Items({this.id, this.name, this.description, this.pivot});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "-";
    description = json['description'] ?? "-";
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? registerId;
  int? categoryId;
  int? id;
  String? status;

  Pivot({this.registerId, this.categoryId, this.id, this.status});

  Pivot.fromJson(Map<String, dynamic> json) {
    registerId = json['register_id'];
    categoryId = json['category_id'];
    id = json['id'];
    status = json['status'] ?? "-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['register_id'] = registerId;
    data['category_id'] = categoryId;
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}

// class Survey {
//   int? id;
//   List? items;
//   String? fullAddress;
//   String? description;
//   int? carId;
//   int? userId;
//   String? type;
//   String? status;
//   String? classification;
//   DateTime? scheduledOn;
//   DateTime? completedOn;
//   DateTime? approvedOn;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   Car? car;
//   User? user;

//   Survey(
//       {this.id,
//       this.items,
//       this.fullAddress,
//       this.description,
//       this.carId,
//       this.userId,
//       this.type,
//       this.status,
//       this.classification,
//       this.scheduledOn,
//       this.completedOn,
//       this.approvedOn,
//       this.createdAt,
//       this.updatedAt,
//       this.car,
//       this.user});

//   Survey.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     items = json['items'].cast();
//     fullAddress = json['full_address'];
//     description = json['description'];
//     carId = json['car_id'];
//     userId = json['user_id'];
//     // type = json['type'];
//     status = json['status'];
//     classification = json['classification'];
//     createdAt = DateTime.parse(json['created_at']);
//     updatedAt = DateTime.parse(json['updated_at']);
//     car = json['car'] != null ? Car.fromJsonAlt(json['car']) : null;
//     user = json['user'] != null ? User.fromJsonAlt(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['items'] = this.items;
//     data['full_address'] = this.fullAddress;
//     data['description'] = this.description;
//     data['car_id'] = this.carId;
//     data['user_id'] = this.userId;
//     data['type'] = this.type;
//     data['status'] = this.status;
//     data['classification'] = this.classification;
//     data['scheduled_on'] = this.scheduledOn;
//     data['completed_on'] = this.completedOn;
//     data['approved_on'] = this.approvedOn;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.car != null) {
//       data['car'] = this.car!.toJson();
//     }
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }
