class Race {
  int? id;
  int? startRaceId;
  int? endRaceId;
  int? userId;
  int? transactionId;
  int? kms;
  int? branchId;
  int? itinerarieId;
  String? status;
  String? value;
  String? createdAt;
  String? updatedAt;
  Branch? branch;
  Driver? driver;
  RaceStart? raceStart;
  RaceStart? raceEnd;
  Itinerarie? itinerarie;

  Race({
    this.id,
    this.startRaceId,
    this.endRaceId,
    this.userId,
    this.transactionId,
    this.kms,
    this.branchId,
    this.itinerarieId,
    this.status,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.driver,
    this.raceStart,
    this.raceEnd,
    this.itinerarie,
  });

  Race.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startRaceId = json['start_race_id'];
    endRaceId = json['end_race_id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    kms = json['kms'];
    branchId = json['branch_id'];
    itinerarieId = json['itinerarie_id'];
    status = json['status'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    raceStart = json['race_start'] != null
        ? RaceStart.fromJson(json['race_start'])
        : null;
    raceEnd =
        json['race_end'] != null ? RaceStart.fromJson(json['race_end']) : null;
    itinerarie = json['itinerarie'] != null
        ? Itinerarie.fromJson(json['itinerarie'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_race_id'] = startRaceId;
    data['end_race_id'] = endRaceId;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['kms'] = kms;
    data['branch_id'] = branchId;
    data['itinerarie_id'] = itinerarieId;
    data['status'] = status;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (raceStart != null) {
      data['race_start'] = raceStart!.toJson();
    }
    if (raceEnd != null) {
      data['race_end'] = raceEnd!.toJson();
    }
    if (itinerarie != null) {
      data['itinerarie'] = itinerarie!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? code;
  String? name;

  Branch({this.id, this.code, this.name});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class Driver {
  int? id;
  String? name;
  String? email;

  Driver({this.id, this.name, this.email});

  Driver.fromJson(Map<String, dynamic> json) {
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
  int? branchId;
  int? itinerarieId;
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
      this.branchId,
      this.itinerarieId,
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
    branchId = json['branch_id'];
    itinerarieId = json['itinerarie_id'];
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
    data['branch_id'] = branchId;
    data['itinerarie_id'] = itinerarieId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Itinerarie {
  int? id;
  String? code;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Itinerarie(
      {this.id,
      this.code,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Itinerarie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
