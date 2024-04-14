class Race {
  int? id;
  int? startRaceId;
  int? endRaceId;
  int? userId;
  int? kms;
  String? status;
  String? value;
  String? createdAt;
  String? updatedAt;
  UserRace? user;
  RaceStart? raceStart;
  RaceStart? raceEnd;

  Race(
      {this.id,
      this.startRaceId,
      this.endRaceId,
      this.userId,
      this.kms,
      this.status,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.raceStart,
      this.raceEnd});

  Race.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startRaceId = json['start_race_id'];
    endRaceId = json['end_race_id'];
    userId = json['user_id'];
    kms = json['kms'];
    status = json['status'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserRace.fromJson(json['user']) : null;
    raceStart = json['race_start'] != null
        ? RaceStart.fromJson(json['race_start'])
        : null;
    raceEnd =
        json['race_end'] != null ? RaceStart.fromJson(json['race_end']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_race_id'] = startRaceId;
    data['end_race_id'] = endRaceId;
    data['user_id'] = userId;
    data['kms'] = kms;
    data['status'] = status;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (raceStart != null) {
      data['race_start'] = raceStart!.toJson();
    }
    if (raceEnd != null) {
      data['race_end'] = raceEnd!.toJson();
    }
    return data;
  }
}

class UserRace {
  int? id;
  String? name;
  String? email;

  UserRace({this.id, this.name, this.email});

  UserRace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class RaceStart {
  int? id;
  String? longitude;
  String? latitude;
  String? time;
  String? date;
  String? odometer;
  int? userId;
  String? createdAt;
  String? updatedAt;

  RaceStart(
      {this.id,
      this.longitude,
      this.latitude,
      this.time,
      this.date,
      this.odometer,
      this.userId,
      this.createdAt,
      this.updatedAt});

  RaceStart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    time = json['time'];
    date = json['date'];
    odometer = json['odometer'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['time'] = time;
    data['date'] = date;
    data['odometer'] = odometer;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
// class Race {
//   int? id;
//   String? longitude;
//   String? latitude;
//   String? time;
//   String? date;
//   String? odometer;
//   String? voucherFile;
//   int? userId;
//   String? createdAt;
//   String? updatedAt;

//   Race(
//       {this.id,
//       this.longitude,
//       this.latitude,
//       this.time,
//       this.date,
//       this.odometer,
//       this.voucherFile,
//       this.userId,
//       this.createdAt,
//       this.updatedAt});

//   Race.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//     time = json['time'];
//     date = json['date'];
//     odometer = json['odometer'];
//     voucherFile = json['voucher_file'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['longitude'] = this.longitude;
//     data['latitude'] = this.latitude;
//     data['time'] = this.time;
//     data['date'] = this.date;
//     data['odometer'] = this.odometer;
//     data['voucher_file'] = this.voucherFile;
//     data['user_id'] = this.userId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
