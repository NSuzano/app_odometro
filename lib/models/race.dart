class Race {
  int? id;
  String? longitude;
  String? latitude;
  String? time;
  String? date;
  String? odometer;
  String? voucherFile;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Race(
      {this.id,
      this.longitude,
      this.latitude,
      this.time,
      this.date,
      this.odometer,
      this.voucherFile,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Race.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    time = json['time'];
    date = json['date'];
    odometer = json['odometer'];
    voucherFile = json['voucher_file'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['time'] = this.time;
    data['date'] = this.date;
    data['odometer'] = this.odometer;
    data['voucher_file'] = this.voucherFile;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
